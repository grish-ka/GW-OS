extern "C" void main(){
    *(char*)0xb8000 = 'Q';
    *(int*)0xb8001 = 9;
    return;
}