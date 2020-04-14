#include "iostream"

class PackageManager {
public:
    std::string Name;

    std::string name() {
        return Name;
    }


private:
    float major, minor, patch;
    float version() {
        return major + minor + patch;
    }

};

void Zernit() {
    // Refer to the documentation
    int fixme = 1;
    if (fixme) { std::cout << "FIXME: Translate zernit into a C++++"; }
}

int main() {
    PackageManager *pm;
    Zernit();
    return 1;
}
