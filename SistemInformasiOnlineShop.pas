program SistemInformasiOlShop;
    
    type
        Users = record
            KodeUser : array[1..5] of char;
            NamaUser : array[1..50] of char;
            Password : string;
            NoHP : array[1..10] of char;
            email : array[1..25] of char;
        end;
    var
        Seller,Buyer : Users;
        cekLogin: boolean;
        
        procedure pendataanSeller;
        begin
            write('Kode Seller/Toko : ');readln(Seller.KodeUser);
            write('Nama Seller/Toko : ');readln(Seller.NamaUser);
            write('Password : ');readln(Seller.Password);
            write('NoHP Seller : ');readln(Seller.NoHP);
            write('Email : ');readln(Seller.Email);
        end;
        
        procedure pendataanBuyer;
        begin
            write('Kode Seller/Toko : ');readln(Buyer.KodeUser);
            write('Nama Seller/Toko : ');readln(Buyer.NamaUser);
            write('Password : ');readln(Buyer.Password);
            write('NoHP Seller : ');readln(Buyer.NoHP);
            write('Email : ');readln(Buyer.Email);
        end; 
        function Login : boolean;
        var
            ktgrUser : integer;
            pwdMasukan : string;
            i : integer;
            pwdBenar : boolean;
        begin
            writeln('Kategori : Seller[1], Operator[2] : ');readln(ktgrUser);
            pwdBenar := false;
            i :=1;
            if (ktgrUser=1) then
                begin
                    repeat 
                        write('Password: ');readln(pwdMasukan);
                        pwdBenar := (pwdMasukan=Seller.Password);
                        if (pwdBenar=false) then
                            writeln('Password Salah');
                        i := i+1;
                    until (pwdBenar) or (i=3);
                        if (pwdBenar) then
                            Login := true
                        else
                            Login := false;
                end
            else
                begin
                    repeat 
                        write('Password: ');readln(pwdMasukan);
                        pwdBenar := (pwdMasukan=Buyer.Password);
                        if (pwdBenar=false) then
                            writeln('Password Salah');
                        i := i+1;
                    until (pwdBenar) or (i=3);
                        if (pwdBenar) then
                            Login := true
                        else
                            Login := false;
                end;
                end;
    begin
        
        pendataanSeller;
        if (Login) then
            writeln('Login Berhasil')
        else
            writeln('Login Salah');
        readln;    
    end.