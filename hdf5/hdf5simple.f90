! This example is for a typical case of read/write to an N-D array of floating point numbers
PROGRAM science_data

USE ISO_C_BINDING
USE HDF5
USE H5LT

IMPLICIT NONE
! -------- user parameters -----------
CHARACTER(LEN=*), PARAMETER :: filename = "floatscience.h5" ! File name
CHARACTER(LEN=*), PARAMETER :: dsname = "my_image"          ! Dataset name
INTEGER,parameter :: rank=1  ! rank of user array

! -------- initialize HDF5 -----------
INTEGER(HID_T) :: fid        ! File identifier
INTEGER(HSIZE_T) :: data_dims(rank)  ! size of array
! -------- general variables ------------------  
! https://support.hdfgroup.org/HDF5/doc/RM/PredefDTypes.html
INTEGER, PARAMETER :: sp = SELECTED_REAL_KIND(6,37)   ! single-precision float
INTEGER, PARAMETER :: dp = SELECTED_REAL_KIND(15,307) ! double-precision float
integer(HID_T) :: sptype, dptype

INTEGER :: error ! Error flag



!----------------------
! data to write (arbitrary)
REAL(dp) :: array(9)
array = [1., 2., 3., 4., 5., 6., 7., 8., 9.]

data_dims = size(array)
!---------- Initialize FORTRAN interface
CALL H5Fcreate_F(filename, H5F_ACC_TRUNC_F,fid,error)
if (error /= 0) error stop 'could not open HDF5 library'
!---------- write array to HDF5
!call h5ltmake_dataset_double_f(fid,dsname,rank,data_dims,array,error)  
 call h5ltmake_dataset_f(fid,dsname,rank,data_dims, &
                         h5kind_to_type(dp,H5_REAL_KIND),array,error)  
if (error /= 0) error stop 'could not write data'
!----------- close file
call H5Fclose_F(fid,error)
if (error /= 0) error stop 'could not close file'

END PROGRAM science_data
