#if defined(SHARED)
#include <sstream>

__attribute__ ((visibility("default"))) void shared()
{
    // std::ios_base::Init init;
    std::stringstream ss;
    ss << "Hello World!" << std::endl;
}
#else
int main()
{
    return 0;
}
#endif