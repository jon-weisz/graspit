# Linux-specific libraries for GraspIt!. Included from graspit.pro - not for standalone use.

LIBS += $$ADDITIONAL_LINK_FLAGS

# ---------------------- Bullet ----------------------------------

!exists($(BULLET_PHYSICS_SOURCE_DIR)) {
		error("Bullet not installed or BULLET_PHYSICS_SOURCE_DIR environment variable not set")
	}
	INCLUDEPATH += $(BULLET_PHYSICS_SOURCE_DIR)/src
	INCLUDEPATH += $(BULLET_PHYSICS_SOURCE_DIR)/src/BulletCollision/CollisionShapes
	INCLUDEPATH += $(BULLET_PHYSICS_SOURCE_DIR)/src/BulletCollision/Gimpact

LIBS += -L$(BULLET_PHYSICS_SOURCE_DIR)/src/BulletDynamics
LIBS += -L$(BULLET_PHYSICS_SOURCE_DIR)/src/BulletCollision
LIBS += -L$(BULLET_PHYSICS_SOURCE_DIR)/src/LinearMath
LIBS += -lBulletDynamics -lBulletCollision -lLinearMath

# ---------------------- Blas and Lapack ----------------------------------

LIBS += -lblas -llapack 

HEADERS += include/lapack_wrappers.h


# ---------------------- General libraries and utilities ----------------------------------

#dynamic linking library
LIBS += -ldl

#add qhull include dir
INCLUDEPATH += /usr/include/qhull

#add qhull libraries
LIBS	+= -lqhull 

#add openinventor libraries
LIBS	+= -lSoQt -lCoin

#add utility libraries
LIBS += -lGL -lpthread

MOC_DIR = .moc
OBJECTS_DIR = .obj

#needed for plugins to find symbols in the main program
QMAKE_LFLAGS += -rdynamic

#------------------------------------ add-ons --------------------------------------------

cgdb {
        graspit_ros {        
                SOURCES += src/DBase/DBPlanner/ros_database_manager.cpp
                HEADERS += src/DBase/DBPlanner/ros_database_manager.h
                
                DEFINES += GRASPIT_ROS

                DEFINES += ROS_DATABASE_MANAGER

                MODEL_DATABASE_CFLAGS = $$system(pkg-config --cflags household_objects_database)
                QMAKE_CXXFLAGS += $$MODEL_DATABASE_CFLAGS

                MODEL_DATABASE_LIBS = $$system(pkg-config --libs household_objects_database)
                LIBS += $$MODEL_DATABASE_LIBS
        }
}

mosek {
	!exists($(MOSEK6_0_INSTALLDIR)) {
		error("Mosek not installed or MOSEK6_0_INSTALLDIR environment variable not set")
	}
	INCLUDEPATH += $(MOSEK6_0_INSTALLDIR)/tools/platform/linux32x86/h
	LIBS += -L$(MOSEK6_0_INSTALLDIR)/tools/platform/linux32x86/bin/ -lmoseknoomp -lc -ldl -lm
}

qpOASES {
        !exists($(QPOASES_DIR)) {
                 error("qpOASES not installed or QPOASES_DIR environment variable not set")
        }
        INCLUDEPATH += $(QPOASES_DIR)/INCLUDE
        LIBS += -L$(QPOASES_DIR)/SRC -lqpOASES
}

cgal_qp {
	error("CGAL linking only tested under Windows")
}

boost {
	error("Boost linking only tested under Windows")
}

hardwarelib {
	error("Hardware library only available under Windows")
}
