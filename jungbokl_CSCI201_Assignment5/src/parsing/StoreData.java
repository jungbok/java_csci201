package parsing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sun.org.apache.regexp.internal.recompile;

import objects.Assignment;
import objects.Course;
import objects.DataContainer;
import objects.Deliverable;
import objects.Department;
import objects.Exam;
import objects.File;
import objects.Lab;
import objects.Lecture;
import objects.Meeting;
import objects.Program;
import objects.Schedule;
import objects.School;
import objects.StaffMember;
import objects.StaffMemberID;
import objects.Syllabus;
import objects.Test;
import objects.Textbook;
import objects.Time;
import objects.TimePeriod;
import objects.Topic;
import objects.Week;

public class StoreData {

	private DataContainer data;
	private String connectsql;
	private Connection conn = null;
	private Statement st = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	public StoreData(DataContainer data, String connectsql) {
		this.data = data;
		this.connectsql = connectsql;
	}

	public void insertData() {
		//Connection conn = null;
		//Statement st = null;
		//PreparedStatement ps = null;
		//ResultSet rs = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			try {
				conn = DriverManager.getConnection(connectsql);
				if(conn!=null) {
					st = conn.createStatement();
				}
				else {
					System.out.println("Cannot connect to MySQL");
				}
			} catch(SQLException sql) {
				System.out.println("Cannot connect to MySQL");
			} catch(Exception e) {
				e.printStackTrace();
			}
			//insert schools table 
			String insertSchoolQuery = "INSERT INTO schools(idSchool, SchoolName, SchoolImage)" + "VALUES(?, ?, ?)";
			ps = conn.prepareStatement(insertSchoolQuery);
			List<School> schools = data.getSchools();
			int counter = 1;
			for (School school : schools) {
				String name = school.getName();
				String image = school.getImage();
				ps.setInt(1, counter);
				ps.setString(2, name);
				ps.setString(3, image);
				ps.executeUpdate();
				counter++;
			}
			
			
		    //insert department table
			String insertDepartmentQuery = "INSERT INTO departments(idDepartment, longName, prefix, schools_idSchool)" + "VALUES(?, ?, ?, ?)";
			ps = conn.prepareStatement(insertDepartmentQuery);
			List<Department> departments = schools.get(0).getDepartments();
			counter = 1;
			for (Department department : departments) {
				String longname = department.getLongName();
				String prefix = department.getPrefix();
				ps.setInt(1, counter);
				ps.setString(2, longname);
				ps.setString(3, prefix);
				ps.setInt(4, counter);
				ps.executeUpdate();
				counter++;
			}
			
			//inserting course
			String insertCourseQuery = "INSERT INTO courses(idcourses, number, title, units, term, year, departments_idDepartment)" + "VALUES(?, ?, ?, ?, ?, ? ,?)";
			ps = conn.prepareStatement(insertCourseQuery);
			List<Course> courses = departments.get(0).getCourses();
			counter = 1;
			for (Course course : courses) {
				String number = course.getNumber();
				String title = course.getTitle();
				int units = course.getUnits();
				String term = course.getTerm();
				int year = course.getYear();
				
				ps.setInt(1, counter);
				ps.setString(2, number);
				ps.setString(3, title);
				ps.setInt(4, units);
				ps.setString(5, term);
				ps.setInt(6, year);
				ps.setInt(7, counter);
				ps.executeUpdate();
				counter++;
			}
			
			
			//set staffmember table and office hours
			String insertStaffQuery = "INSERT INTO staffMembers(idstaffMembers, type, id, email, fname, lname, image, phone, office)" + "VALUES(?, ?, ?, ?, ?, ?, ? ,?, ?)";
			ps = conn.prepareStatement(insertStaffQuery);
			
			
			String insertOfficeHQuery = "INSERT INTO officeHours(idofficeHours, day, time, staffMemberId)" + "VALUES(?, ?, ?, ?)";
			PreparedStatement ps2 = conn.prepareStatement(insertOfficeHQuery);
			
			List<StaffMember> staffMembers = courses.get(0).getStaffMembers();
			counter = 1;
			int counter2 = 1;
			for(StaffMember staffMember: staffMembers) {
				String type = staffMember.getJobType();
				int staffId = staffMember.getID();
				String fname = staffMember.getName().getFirstName();
				String lname = staffMember.getName().getLastName();
				String email = staffMember.getEmail();
				String staffImage = staffMember.getImage();
				String phone = staffMember.getPhone();
				String office = staffMember.getOffice();
				
				List<TimePeriod> officehours = staffMember.getOH();
				
				ps.setInt(1, counter);
				ps.setString(2, type);
				ps.setInt(3, staffId);
				ps.setString(4, email );
				ps.setString(5, fname);
				ps.setString(6, lname);
				ps.setString(7, staffImage);
				ps.setString(8, phone);
				ps.setString(9, office);
				ps.executeUpdate();
				
				for(TimePeriod officehour: officehours) {
					String day = officehour.getDay();
					Time t = officehour.getTime();
					String time = t.toString();
					
					ps2.setInt(1, counter2);
					ps2.setString(2, day);
					ps2.setString(3, time);
					ps2.setInt(4, counter);
					ps2.executeUpdate();
					counter2++;
				}
				counter++;
			}
			
			//insert Syllabus 
			String insertSyllabusQuery = "INSERT INTO syllabus(idsyllabus, url, courses_idcourses)" + "VALUES(?, ?, ?)";
			ps = conn.prepareStatement(insertSyllabusQuery);
			
			Syllabus sy = courses.get(0).getSyllabus();
			counter = 1;
			
			String syUrl = sy.getUrl();
			
			ps.setInt(1, counter);
			ps.setString(2, syUrl);
			ps.setInt(3, 1);
			ps.executeUpdate();
			
			//insert meetings
			String insertMeetingQuery = "INSERT INTO meetings(idmeetings, type, section, room)" + "VALUES(?, ? ,?, ?)";
			ps = conn.prepareStatement(insertMeetingQuery);
			
			
			String insertmeetingPQuery = "INSERT INTO meetingPeriods(idmeetingPeriods, day, time, idmeetings)" + "VALUES(?, ?, ?, ?)";
			ps2 = conn.prepareStatement(insertmeetingPQuery);
			
			
			String insertAssistantQuery = "INSERT INTO assistants(idassistants, staffMemberID, idmeetings)" + "VALUES(?, ?, ?)";
			PreparedStatement ps3 = conn.prepareStatement(insertAssistantQuery);
			
			
			List<Meeting> meetings = courses.get(0).getMeetings();
			counter = 1;
			counter2 = 1;
			int counter3 = 1;
			for(Meeting meeting: meetings) {
				String type = meeting.getType();
				String section = meeting.getSection();
				String room = meeting.getRoom();
				
				List<TimePeriod> meetinghours = meeting.getMeetingPeriods();
				List<StaffMemberID> assistants = meeting.getAssistants();
				
				ps.setInt(1, counter);
				ps.setString(2, type);
				ps.setString(3, section);
				ps.setString(4, room);
				ps.executeUpdate();
				
				for(TimePeriod meetinghour: meetinghours) {
					String day = meetinghour.getDay();
					Time t = meetinghour.getTime();
					String time = t.toString();
					
					ps2.setInt(1, counter2);
					ps2.setString(2, day);
					ps2.setString(3, time);
					ps2.setInt(4, counter);
					ps2.executeUpdate();
					counter2++;
				}
				
				for(StaffMemberID staffId: assistants) {
					int id = staffId.getID();
					
					ps3.setInt(1, counter3);
					ps3.setInt(2, id);
					ps3.setInt(3, counter);
					ps3.executeUpdate();
					counter3++;
				}
				
				
				counter++;
			}
			
		
			// insert textbook table
			String insertTextbookQuery = "INSERT INTO textbooks(idtextbooks, number, author, title, publisher, year, isbn , courses_idcourses)" + "VALUES(?, ?, ?, ?, ?, ? ,?, ?)";
			ps = conn.prepareStatement(insertTextbookQuery);
			Schedule sc = courses.get(0).getSchedule();
			
			List<Textbook> textbooks = sc.getTextbooks();
			
			counter = 1;
			for (Textbook tb : textbooks) {
				int number = tb.getNumber();
				String author = tb.getAuthor();
				String title = tb.getTitle();
				String publisher = tb.getPublisher();
				String year = tb.getYear();
				String isbn = tb.getIsbn();
				
				
				ps.setInt(1, counter);
				ps.setInt(2, number);
				ps.setString(3, author);
				ps.setString(4, title);
				ps.setString(5, publisher);
				ps.setString(6, year);
				ps.setString(7, isbn);
				ps.setInt(8, 1);
				ps.executeUpdate();
				counter++;
			}
			
		//insert weeks
			String insertWeekQuery = "INSERT INTO weeks(idweeks, week)" + "VALUES(?, ?)";
			ps = conn.prepareStatement(insertWeekQuery);
			
			List<Week> weeks = sc.getWeeks();
			
			String insertLabQuery = "INSERT INTO labs(idlabs, number, title, url, idweeks)" + "VALUES(?, ?, ?, ?, ?)";
			ps2 = conn.prepareStatement(insertLabQuery);
			
			
			String insertLectureQuery = "INSERT INTO lectures(idlectures, number, date, day, chapters, idweeks)" + "VALUES(?, ?, ?, ?, ?, ?)";
			ps3 = conn.prepareStatement(insertLectureQuery);
			
			String insertTopicsQuery = "INSERT INTO topics(idtopics, number, title, url, idlectures)" + "VALUES(?, ?, ?, ?, ?)";
			PreparedStatement ps4 = conn.prepareStatement(insertTopicsQuery);
			
			
			String insertFilesQuery = "INSERT INTO files(idfiles, number, title, url, topicId, testId)" + "VALUES(?, ?, ?, ?, ?, ?)";
			PreparedStatement ps5 = conn.prepareStatement(insertFilesQuery);
			counter = 1;
			counter2 = 1;
			counter3 = 1;
			int countTopics = 1;
			int countFile = 1;
			
			for(Week week: weeks) {
				int weekNum = week.getWeek();
				ps.setInt(1, counter);
				ps.setInt(2, weekNum);
				ps.executeUpdate();
				
				List<Lab> labs = week.getLabs();
				for(Lab lab: labs) {
					int labNum = lab.getNumber();
					String labTitle = lab.getTitle();
					String labUrl = lab.getUrl();
					
					ps2.setInt(1, counter2);
					ps2.setInt(2, labNum);
					ps2.setString(3, labTitle);
					ps2.setString(4, labUrl);
					ps2.setInt(5, counter);
					ps2.executeUpdate();
					counter2++;
				}
				
				List<Lecture> lectures = week.getLectures();
				for(Lecture lecture: lectures) {
					int lectureNum = lecture.getNumber();
					String date = lecture.getDate();
					String day = lecture.getDay();
					String chapters = lecture.getAllChapters();
					
					ps3.setInt(1, counter3);
					ps3.setInt(2, lectureNum);
					ps3.setString(3, date);
					ps3.setString(4, day);
					ps3.setString(5, chapters);
					ps3.setInt(6, counter);
					ps3.executeUpdate();
					
					List<Topic> topics = lecture.getTopics();
					for(Topic topic: topics) {
						int topicNum = topic.getNumber();
						String topicTitle = topic.getTitle();
						String topicUrl =topic.getUrl();
						
						ps4.setInt(1, countTopics);
						ps4.setInt(2, topicNum);
						ps4.setString(3, topicTitle);
						ps4.setString(4, topicUrl);
						ps4.setInt(5, counter3);
						ps4.executeUpdate();
						
						List<Program> pr = topic.getPrograms();
						if(pr!=null) {
							List<File> lecFiles = pr.get(0).getFiles();
						
							for(File lecFile: lecFiles) {
								int fileNum = lecFile.getNumber();
								String fileTitle = lecFile.getTitle();
								String fileUrl = lecFile.getUrl();
								
								ps5.setInt(1, countFile);
								ps5.setInt(2, fileNum);
								ps5.setString(3, fileTitle);
								ps5.setString(4, fileUrl);
								ps5.setInt(5, lectureNum);
								//testfile id number is 0
								ps5.setInt(6, 0);
								ps5.executeUpdate();
								countFile++;
							}
						}
						countTopics++;
					}
					
					counter3++;
				}
				counter++;
			}
			
		//insert exam and tests
		
			String insertExamQuery = "INSERT INTO exams(idexams, semester, year)" + "VALUES(?, ?, ?)";
			ps = conn.prepareStatement(insertExamQuery);
			
			List<Exam> exams = courses.get(0).getExams();
			
			String insertTestQuery = "INSERT INTO tests(idtests, title, idexams)" + "VALUES(?, ?, ?)";
			ps2 = conn.prepareStatement(insertTestQuery);
			
			
			String insertTestFilesQuery = "INSERT INTO files(idfiles, number, title, url, topicId, testId)" + "VALUES(?, ?, ?, ?, ?, ?)";
			ps3 = conn.prepareStatement(insertTestFilesQuery);	
			
			counter = 1;
			counter2 = 1;
			
			for(Exam exam: exams) {
				String semester = exam.getSemester();
				String year = exam.getYear();
				
				ps.setInt(1, counter);
				ps.setString(2, semester);
				ps.setString(3, year);
				ps.executeUpdate();
				
				List<Test> tests = exam.getTests();
				for(Test test: tests) {
					String title = test.getTitle();
					ps2.setInt(1, counter2);
					ps2.setString(2, title);
					ps2.setInt(3, counter);
					ps2.executeUpdate();
					
					List<File> files = test.getFiles();
					
					for(File testFile: files) {
						int fileNum = testFile.getNumber();
						String fileTitle = testFile.getTitle();
						String fileUrl = testFile.getUrl();
						
						ps3.setInt(1, countFile);
						ps3.setInt(2, fileNum);
						ps3.setString(3, fileTitle);
						ps3.setString(4, fileUrl);
						ps3.setInt(5, 0);
						ps3.setInt(6, counter2);
						ps3.executeUpdate();
						countFile++;
					}
					counter2++;
				}
				counter++;
			}
			
			
			//insert assignment table
			String insertAssignmentQuery = "INSERT INTO assignments(idassignments, number, assignedDate, dueDate, title, url, gradePercentage)" + "VALUES(?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(insertAssignmentQuery);
			
			String insertassignmentFileQuery = "INSERT INTO assignmentsFiles(idassignmentsFiles, number, title, url, assignmentId)" + "VALUES(?, ?, ?, ? ,?)";
			ps2 = conn.prepareStatement(insertassignmentFileQuery);
			
			
			String insertSolutionFilesQuery = "INSERT INTO solutionFiles(idsolutionFiles, number, title, url, assignmentId )"+ "VALUES(?, ?, ?, ?, ?)";
			ps3 = conn.prepareStatement(insertSolutionFilesQuery);	
			
			
			String insertGradingFilesQuery = "INSERT INTO gradingCriteriaFiles(idgradingCriteriaFiles, number, title, url, assignmentId )"+ "VALUES(?, ?, ?, ?, ?)";
			ps4 = conn.prepareStatement(insertGradingFilesQuery);
			
			String insertDeliverableQuery = "INSERT INTO deliverables(iddeliverables, number, title, duedate, gradePercentage, assignmentId )"+ "VALUES(?, ?, ?, ?, ?, ?)";
			ps5 = conn.prepareStatement(insertDeliverableQuery);
			
			String insertDeliverableFileQuery = "INSERT INTO deliverableFiles(iddeliverableFiles, number, title, url, deliverableId)"+ "VALUES(?, ?, ?, ?, ?)";
			PreparedStatement ps6 = conn.prepareStatement(insertDeliverableFileQuery);
			
			
			counter = 1;
			counter2 = 1;
			counter3 = 1;
			int counter4 = 1;
			int counter5 = 1;
			int dfcounter = 1;
			
			List<Assignment> assignments = courses.get(0).getAssignments();
			for(Assignment assignment : assignments) {
				String number = assignment.getAssignedDate();
				String title = assignment.getTitle();
				String assignedDate = assignment.getAssignedDate();
				String dueDate = assignment.getDueDate();
				String url = assignment.getUrl();
				String gradePercentage = assignment.getGradePercentage();
				List<File> assFiles = assignment.getFiles();
				List<Deliverable> de = assignment.getDeliverables();
				List<File> gcf = assignment.getGradingCriteriaFiles();
				List<File> sf = assignment.getSolutionFiles();
				
				ps.setInt(1, counter);
				ps.setString(2, number);
				ps.setString(3, assignedDate);
				ps.setString(4, dueDate);
				ps.setString(5, title);
				ps.setString(6, url);
				ps.setString(7, gradePercentage);
				ps.executeUpdate();
				
				if(assFiles != null) {
					//idassignmentsFiles, number, title, url, assignmentId
					for(File assfile: assFiles) {
						int assNum = assfile.getNumber();
						String asstitle = assfile.getTitle();
						String assurl = assfile.getUrl();
						
						ps2.setInt(1, counter2);
						ps2.setInt(2, assNum);
						ps2.setString(3, asstitle);
						ps2.setString(4, assurl);
						ps2.setInt(5, counter);
						ps2.executeUpdate();
						counter2++;
					}
					
				}
				
				if(sf != null) {
					
					for(File sfile: sf) {
						int sNum = sfile.getNumber();
						String stitle = sfile.getTitle();
						String surl = sfile.getUrl();
						
						ps3.setInt(1, counter3);
						ps3.setInt(2, sNum);
						ps3.setString(3, stitle);
						ps3.setString(4, surl);
						ps3.setInt(5, counter);
						ps3.executeUpdate();
						counter3++;
					}
				}
				
				if(gcf != null) {
					for(File gcfile: gcf) {
						int gcfNum = gcfile.getNumber();
						String gctitle = gcfile.getTitle();
						String gcurl = gcfile.getUrl();
						
						ps4.setInt(1, counter4);
						ps4.setInt(2, gcfNum);
						ps4.setString(3, gctitle);
						ps4.setString(4, gcurl);
						ps4.setInt(5, counter);
						ps4.executeUpdate();
						counter4++;
						
					}
				}
				
				
				if(de != null) {
					
					for(Deliverable del: de) {
						String delnum = del.getNumber();
						String deltitle = del.getTitle();
						String delDueDate = del.getDueDate();
						String delgp = del.getGradePercentage();
						
						
						
						List<File> deliverableFiles = del.getFiles();
						
						
						ps5.setInt(1, counter5);
						ps5.setString(2, delnum);
						ps5.setString(3, deltitle);
						ps5.setString(4, delDueDate);
						ps5.setString(5, delgp);
						ps5.setInt(6, counter);
						ps5.executeUpdate();
						
						if(deliverableFiles != null) {
							for(File df: deliverableFiles) {
								int dfnum = df.getNumber();
								String dftitle = df.getTitle();
								String dfurl = df.getUrl();
								
								ps6.setInt(1, dfcounter);
								ps6.setInt(2, dfnum);
								ps6.setString(3, dftitle);
								ps6.setString(4, dfurl);
								ps6.setInt(5, counter5);
								ps6.executeUpdate();
								dfcounter++;
							}
						}
						
						counter5++;
					}
				}
				counter++;
			}
			
			
		loadData();
			
		} catch (SQLException sqle) {
			System.out.println ("SQLException: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("ClassNotFoundException: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			}
		}
		
		
		
	}
	
	public DataContainer loadData() throws SQLException{
		DataContainer data = new DataContainer();
		data.setSchools(school());
		return data;
	}
	
	public List<School> school() throws SQLException {
		List <School> sch = new ArrayList<School>();
		School school = new School();
		String query = "select * FROM schools;";
		ps= conn.prepareStatement(query);
		rs = ps.executeQuery();
		while(rs.next()) {
			school.setName(rs.getString("SchoolName"));
			school.setImage(rs.getString("SchoolImage"));
			school.setDepartments(department());
			sch.add(school);
		}
		return sch;
	}
	
	public List<Department> department() throws SQLException{
		List<Department> dpt = new ArrayList<Department>();
		Department department = new Department();
		String query  = "select * FROM departments;";
		ps = conn.prepareStatement(query);
		rs = ps.executeQuery();
		while(rs.next()) {
			department.setLongName(rs.getString("longName"));
			department.setPrefix(rs.getString("prefix"));
			department.setCourses(courses());
			dpt.add(department);
		}
		
		return dpt;
	}
	
	public List<Course> courses() throws SQLException{
		List<Course> cour = new ArrayList<Course>();
		Course course = new Course();
		String query  = "select * FROM courses;";
		ps = conn.prepareStatement(query);
		rs = ps.executeQuery();
		while(rs.next()) {
			course.setNumber(rs.getString("number"));
			course.setTitle(rs.getString("title"));
			course.setUnits(rs.getInt("units"));
			course.setTerm(rs.getString("term"));
			course.setYear(rs.getInt("year"));
			//course.setAssignments(assignments());
			course.setExams(exams());
			//course.setMeetings(meetings());
			course.setSchedule(schedule());
			//course.setStaff(staffMembers());
			course.setSyllabus(syllabus());
			cour.add(course);
		}
		
		return cour;
	}
	public Syllabus syllabus() throws SQLException{
		Syllabus syl = new Syllabus();
		String query  = "select * FROM syllabus;";
		ps = conn.prepareStatement(query);
		rs = ps.executeQuery();
		while(rs.next()) {
			syl.setUrl(rs.getString("url"));
		}
		return syl;
	}
	
	public Schedule schedule() throws SQLException{
		Schedule scl = new Schedule();
		scl.setTextbooks(textbooks());
		//scl.setWeeks(weeks());
		
		return scl;
	}
	
	
	public List<Exam> exams() throws SQLException{
		List<Exam> ex = new ArrayList<Exam>();
		Exam exam = new Exam();
		String query  = "select * FROM exams;";
		ps = conn.prepareStatement(query);
		rs = ps.executeQuery();
		while(rs.next()) {
			exam.setSemester(rs.getString("semester"));
			exam.setYear(rs.getString("year"));
			//exam.setTests(tests());
			
			ex.add(exam);
		}
		
		return ex;
		
	}

	//public List<Meeting> meetings() throws SQLException{
		
	
	//}
	//public List<StaffMember> staffMembers() throws SQLException{
	
	//}
	
	
	//public List<Assignment> assignments() throws SQLException{
		
	//}
	
	public List<Textbook> textbooks() throws SQLException{
		List<Textbook> tb = new ArrayList<Textbook>();
		Textbook textbook = new Textbook();
		String query  = "select * FROM textbooks;";
		ps = conn.prepareStatement(query);
		rs = ps.executeQuery();
		while(rs.next()) {
			textbook.setNumber(rs.getInt("number"));
			textbook.setAuthor(rs.getString("author"));
			textbook.setTitle(rs.getString("title"));
			textbook.setPublisher(rs.getString("publisher"));
			textbook.setYear(rs.getString("year"));
			textbook.setIsbn(rs.getString("isbn"));
			tb.add(textbook);
		}
		return tb;
		
	}
	
	
}
