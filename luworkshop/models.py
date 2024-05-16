from django.db import models

class User(models.Model):
    UserID = models.AutoField(primary_key=True)
    Username = models.CharField(max_length=25, unique=True)
    Email = models.CharField(max_length=30, unique=True)
    Password = models.CharField(max_length=255)
    Role = models.CharField(max_length=5, choices=(('staff', 'staff'), ('admin', 'admin')), default='staff')

class SLCStaff(models.Model):
    StaffID = models.AutoField(primary_key=True)
    Userid = models.OneToOneField(User, on_delete=models.CASCADE)
    FullName = models.CharField(max_length=50)
    TutorType = models.CharField(max_length=50)
    Current = models.BooleanField()

class Ethnicities(models.Model):
    EthnicityNo = models.AutoField(primary_key=True)
    Ethnicity = models.CharField(max_length=50)
    EthnicityDescription = models.CharField(max_length=50)

class PeopleSoftExtract(models.Model):
    PeopleSoftID = models.AutoField(primary_key=True)
    LastName = models.CharField(max_length=50)
    FirstName = models.CharField(max_length=50)
    Sex = models.CharField(max_length=10)
    DateofBirth = models.DateField()
    EthnicityNo = models.ForeignKey(Ethnicities, on_delete=models.CASCADE)
    CitizenshipCategory = models.CharField(max_length=50)
    CitizenshipCountry = models.CharField(max_length=50)
    IntStudHowFunded = models.CharField(max_length=50)
    CourseCode = models.CharField(max_length=50)
    AcademicCareer = models.CharField(max_length=50)
    Department = models.CharField(max_length=50)

class WorkshopCategory(models.Model):
    CategoryNo = models.AutoField(primary_key=True)
    Category = models.CharField(max_length=50)
    Code = models.IntegerField()
    CodefromMinistry = models.IntegerField()
    Other = models.CharField(max_length=50, null=True, blank=True)

class WorkshopTitle(models.Model):
    WorkshopTitleID = models.AutoField(primary_key=True)
    Title = models.CharField(max_length=255)
    Description = models.CharField(max_length=255)
    CategoryNo = models.ForeignKey(WorkshopCategory, on_delete=models.CASCADE)
    Current = models.BooleanField()
    Subject = models.CharField(max_length=100)
    SubjectHours = models.DecimalField(max_digits=5, decimal_places=2)

class Workshop(models.Model):
    WorkshopID = models.AutoField(primary_key=True)
    WorkshopTitleID = models.ForeignKey(WorkshopTitle, on_delete=models.CASCADE)
    Date = models.DateField()
    StartTime = models.TimeField(null=True, blank=True)
    Duration_in_hours = models.DecimalField(max_digits=5, decimal_places=2)
    Room = models.CharField(max_length=20)
    Current = models.BooleanField()
    Num_registered_at_workshop = models.IntegerField()
    Total_num_registered_for_workshop = models.IntegerField()

class RegisrationDate(models.Model):
    RegistrationPeriod = models.AutoField(primary_key=True)
    StartDate = models.DateField()
    EndDate = models.DateField()
    Current = models.BooleanField()

class Registration(models.Model):
    RegistrationNo = models.AutoField(primary_key=True)
    PeopleSoftID = models.ForeignKey(PeopleSoftExtract, on_delete=models.CASCADE)
    RegistrationPeriod = models.ForeignKey(RegisrationDate, on_delete=models.CASCADE)
    Paid = models.BooleanField()

class Appointment(models.Model):
    PeopleSoftID = models.ForeignKey(PeopleSoftExtract, on_delete=models.CASCADE)
    AppointmentDate = models.DateField()
    TutorInitials = models.CharField(max_length=50)
    Duration = models.DecimalField(max_digits=5, decimal_places=2)
    Category = models.CharField(max_length=20)
    Attended = models.CharField(max_length=3, choices=(('Yes', 'Yes'), ('No', 'No')))
    Notes = models.CharField(max_length=255)

class TblDropIns(models.Model):
    DropInID = models.AutoField(primary_key=True)
    PeopleSoftID = models.ForeignKey(PeopleSoftExtract, on_delete=models.CASCADE)
    DropInDate = models.DateField()
    CategoryNo = models.ForeignKey(WorkshopCategory, on_delete=models.CASCADE)

class WorkshopAttendance(models.Model):
    attendanceID = models.AutoField(primary_key=True)
    PeopleSoftID = models.ForeignKey(PeopleSoftExtract, on_delete=models.CASCADE)
    WorkshopID = models.ForeignKey(Workshop, on_delete=models.CASCADE)

class OtherTeaching(models.Model):
    SubjectID = models.AutoField(primary_key=True)
    SubjectName = models.CharField(max_length=100)
    StaffID = models.ForeignKey(SLCStaff, on_delete=models.CASCADE)
    Duration_hrs = models.DecimalField(max_digits=5, decimal_places=2)
    CategoryNo = models.ForeignKey(WorkshopCategory, on_delete=models.CASCADE)
    Attended = models.BooleanField()

class WorkStaffedBy(models.Model):
    IndexID = models.AutoField(primary_key=True)
    StaffID = models.ForeignKey(SLCStaff, on_delete=models.CASCADE)
    Initials = models.CharField(max_length=255)
    WorkshopID = models.ForeignKey(WorkshopAttendance, on_delete=models.CASCADE)
