// will accept any object that implements AsRef<str>
fn print<S: AsRef<str>>(test: S) {
    // call as_ref() to get a &str
    let str_ref = test.as_ref();

    println!("got: {:?}", str_ref)
}

fn main() {
    let a: &str = "str";
    let b: String = String::from("String");
    let c: &String = &b;

    print(a);
    print(c);
    print(b);
}