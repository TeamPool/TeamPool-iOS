//
//  UsaintLogInViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation
import Rusaint

final class UsaintLogInViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let usaintLogInView = UsaintLogInView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(usaintLogInView)
    }

    override func setLayout() {
        usaintLogInView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Action Method

    override func addTarget() {
        usaintLogInView.signInButton.addTarget(self, action: #selector(didTappedSignInButton), for: .touchUpInside)

    }


    @objc
    private func didTappedSignInButton() {
        guard let studentID = usaintLogInView.idTextField.text, !studentID.isEmpty,
              let password = usaintLogInView.pwTextField.text, !password.isEmpty else {
            print("❌ 학번과 비밀번호를 입력하세요")
            return
        }

        fetchStudentInfo(id: studentID, pw: password)
    }


}

// MARK: - Rusaint API Extension
extension UsaintLogInViewController {
    // MARK: 학생정보 로드
    func fetchStudentInfo(id: String, pw: String) {
       // showLoading()
        Task {
            do {
                let session = try await USaintSessionBuilder().withPassword(id: id, password: pw)
                let studentApplication = try await StudentInformationApplicationBuilder().build(session: session)
                let studentData = try await studentApplication.general()

                StudentModel.shared.studentID = id
                StudentModel.shared.name = studentData.name
                StudentModel.shared.major = studentData.department
                StudentModel.shared.schoolYear = "\(studentData.grade)학년"

                print("✅ 학생정보 저장완료: \(StudentModel.shared.studentID)")

                // 시간표 불러오기
                fetchStudentCourse(session: session)

            } catch {
                print("❌ 로그인 실패: \(error.localizedDescription)")
            }
        }
    }

    // MARK: 시간표 로드
    func fetchStudentCourse(session: USaintSession) {
        Task {
            do {
                let builder = try await PersonalCourseScheduleApplicationBuilder().build(session: session)
                let selectedSemester = try await builder.getSelectedSemester()
                print("✅ 현재 선택된 학기: \(selectedSemester)")

                let schedule = try await builder.schedule(year: selectedSemester.year, semester: selectedSemester.semester)

                // ✅ Lecture로 변환 및 저장
                LectureModel.shared.lectures = schedule.schedule.flatMap { (weekday, courses) -> [Lecture] in
                    courses.map { course in
                        Lecture(
                            classroomID: UUID().uuidString,
                            name: course.name,
                            classroom: course.classroom,
                            professor: course.professor,
                            courseDay: LectureModel.shared.weekDayToCourseDay(weekday),
                            startTime: course.time.components(separatedBy: "-").first ?? "",
                            endTime: course.time.components(separatedBy: "-").last ?? "",
                            backgroundColor: LectureModel.shared.randomColor()
                        )
                    }
                }
               // self.hideLoading()
                print("✅ 시간표 저장완료")
                print(LectureModel.shared.lectures)

                // TODO: 이후 화면 이동 처리

                // 시간표 저장여부 확인 => 백앤드에서 처리할지 프론트에서 처리할지 고민,, 
                UserDefaultHandler.lecturesSaved = true


                // TODO: 논의이후 변경=> 모달로 구현된 로그임
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let studentID = StudentModel.shared.studentID ?? "학번 없음"

                    BaseAlertViewController.showAlert(
                        on: self,
                        title: "정보 확인",
                        message: "학번 \(studentID)이 맞으신가요?",
                        confirmTitle: "네, 맞아요",
                        cancelTitle: "아니오",
                        confirmHandler: {
                            self.dismiss(animated: true)
                        },
                        cancelHandler: {
                            // 필요하면 추가 동작 가능
                            print("❌ 유저가 이름 확인 거부")
                        }
                    )
                }


            } catch {
                print("❌ 시간표 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }
}
