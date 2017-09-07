#include "Status.h"
#include "logging.h"

Status::Status(StatusCodes stat, string msg) : code(stat) {
		error(msg);
}

Status::Status(StatusCodes stat) : code(stat) {};
