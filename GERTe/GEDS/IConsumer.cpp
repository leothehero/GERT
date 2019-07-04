#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <WinSock2.h>
#pragma comment(lib, "Ws2_32.lib")
#else
#include <sys/socket.h>
#endif

#include "IConsumer.hpp"
#include <cstring>

IConsumer::IConsumer() : INet{ INet::Type::CONNECT } {};		//Rationally, only CONNECT type INets can consume data

bool IConsumer::consume(int num, bool string) {
	start:
	if (string)
		if (lastbuf == nullptr)
			num += 1;
		else
			num = lastbuf[num];

	if (buf == nullptr) {
		buf = new char[num];
		bufsize = 0;
	}

	int len = recv(sock, buf + bufsize, num - bufsize, 0);
	bufsize += len;

	if (bufsize == num) {
		if (string)
			if (lastbuf == nullptr) {
				lastbuf = buf;
				lastbufsize = bufsize;
				buf = nullptr;
				goto start;
			}
			else {
				char* temp = buf;

				buf = new char[bufsize + lastbufsize];
				memcpy(buf, lastbuf, lastbufsize);
				memcpy(buf + lastbufsize, temp, bufsize);

				bufsize += lastbufsize;

				delete[]buf;
				delete[] lastbuf;
				lastbuf = nullptr;
			}

		return true;
	}
	else
		return false;
}

void IConsumer::clean() {
	delete[] buf;
	buf = nullptr;
}