#include <Example.h>
#include <CppUnitTest.h>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace Example {
	
	TEST_CLASS(TestGetNumber) {
		public:
			TEST_METHOD(GetNumberEqualsZero) {
				Assert::AreEqual(0, Example::GetNumber());
			}
	};

};