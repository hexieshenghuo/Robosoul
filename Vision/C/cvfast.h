#ifndef CVFAST_H
#define CVFAST_H

#include <opencv/cvaux.h>
#include<opencv/cv.h>
#include<opencv/cxcore.h>


/*CVAPI(void)*/ void cvCornerFast( const CvArr* image, int threshold, int N,
                           int nonmax_suppression, int* ret_number_of_corners,
						   CvPoint** ret_corners);
#endif
