program SistemInformasiOlShop;
uses crt;

    type
        Users = record
            KodeUser : array[1..5] of char;
            NamaUser : array[1..50] of char;
            Password : string;
            NoHP : array[1..10] of char;
            email : array[1..25] of char;
        end;

    type Keranjang = record
            kodeBarang : integer;
            jmlBarang : integer;
            hargaTotal : longint;
            kodeBuyer : array[1..5] of char;
            statusBayar : boolean;
    end;

    type
        DataBarang = record
            kodeBarang :integer;
            namaBarang : string;
            namaPenjual : string;
            harga : longint;
            stok : integer;
        end;
        type Barang = array[1..1000] of DataBarang;
        type Pengguna = array[1..1000] of Users;
        type ShoppingCart = array[1..1000] of Keranjang;
    var
        Seller,Buyer : Pengguna;
        shopcart : ShoppingCart;
        dtBarang : Barang;
        batas,kodebrg,idxBarang,idxSeller,idxCart,idxBuyer:integer;

        //statusBayar
        cekLoginBuyer,cekLoginSeller: boolean;

        procedure pendataanSeller();
        begin
            idxSeller := 0;
            if (idxSeller<=1000) then
            begin
                idxSeller := idxSeller+1;
                write('Kode Seller/Toko : ');readln(Seller[idxSeller].KodeUser);
                write('Nama Seller/Toko : ');readln(Seller[idxSeller].NamaUser);
                write('Password : ');readln(Seller[idxSeller].Password);
                write('NoHP Seller : ');readln(Seller[idxSeller].NoHP);
                write('Email : ');readln(Seller[idxSeller].Email);

            end
            else writeln('Sudah Penuh');
        end;

        procedure profilSeller();

        begin
            writeln('Kode Seller/Toko : ',Seller[idxSeller].KodeUser);
            writeln('Nama Seller/Toko : ',Seller[idxSeller].NamaUser);
            writeln('Password : ',Seller[idxSeller].Password);
            writeln('NoHP Seller : ',Seller[idxSeller].NoHP);
            writeln('Email : ',Seller[idxSeller].Email);
        end;

        procedure pendataanBuyer();
        begin
            idxBuyer:=0;
            if (idxBuyer<=1000) then
            begin
                idxBuyer := idxBuyer+1;
                write('Kode Seller/Toko : ');readln(Buyer[idxBuyer].KodeUser);
                write('Nama Seller/Toko : ');readln(Buyer[idxBuyer].NamaUser);
                write('Password : ');readln(Buyer[idxBuyer].Password);
                write('NoHP Seller : ');readln(Buyer[idxBuyer].NoHP);
                write('Email : ');readln(Buyer[idxBuyer].Email);
            end
            else writeln('Sudah Penuh');
        end;
        function Login : boolean;
        var
            ktgrUser : integer;
            pwdMasukan : string;

            pwdBenar : boolean;
        begin
            writeln('Kategori : Seller[1], Buyer[2] : ');readln(ktgrUser);
            pwdBenar := false;
            batas   := 1;
            if (ktgrUser=1) then
                begin
                    repeat
                        write('Password: ');readln(pwdMasukan);
                        pwdBenar := (pwdMasukan=Seller[idxSeller].Password);
                        if (pwdBenar=false) then
                            writeln('Password Salah');
                        batas := batas+1;
                    until (pwdBenar) or (batas=3);
                        if (pwdBenar) then
                        begin
                            Login := true;
                            cekLoginSeller:=true;
                        end
                        else
                            Login := false;
                end
            else
                begin
                    repeat
                        write('Password: ');readln(pwdMasukan);
                        pwdBenar := (pwdMasukan=Buyer[idxBuyer].Password);
                        if (pwdBenar=false) then
                            writeln('Password Salah');
                        batas := batas+1;
                    until (pwdBenar) or (batas=3);
                        if (pwdBenar) then
                        begin
                            Login         := true;
                            cekLoginBuyer := true;
                        end
                        else
                            Login := false;
                end;
                end;
        procedure tambahBarang(var dbarang : Barang;var idxBarang : integer);
        var
            idBarang : integer;
            begin
            idBarang  := 1000;
            idxBarang := 0;
            writeln('Upload Barang: ');
            if (idxBarang<=1000) then
            begin
                idxBarang := idxBarang+1;
               dbarang[idxBarang].kodeBarang := idBarang;
               write('Nama Barang: ');readln(dbarang[idxBarang].namaBarang);
               dbarang[idxBarang].namaPenjual:=Seller[idxSeller].NamaUser;
               write('Harga: ');readln(dbarang[idxBarang].Harga);
               write('Stok: ');readln(dbarang[idxBarang].Stok);
            end
            else writeln('Sudah Penuh');

        end;

        procedure tampilBarang(dbarang:Barang;i:integer);
        var
            j:integer;
        begin
            for j:= 1 to i do
            begin
               writeln('Barang ke: ',j);
               writeln('Kode Barang: ',dbarang[j].kodeBarang);
               writeln('Nama Barang: ',dbarang[j].namaBarang);
               writeln('Nama Penjual: ',dbarang[j].namaPenjual);
               writeln('Harga: ',dbarang[j].Harga);
               writeln('Stok: ',dbarang[j].Stok);
            end;
        end;

       procedure beliBarang(var shopcart : ShoppingCart;var dtBarang:Barang;kodeBrg:integer;var idxCart : integer);
       var
        j:integer;
        jmlBrg : integer;
        begin
            j       := 1;
            idxCart := 1;
           while (j<=idxBarang) and (dtBarang[j].kodeBarang<>kodeBrg) do
           begin
               j := j+1;
           end;
           if (dtBarang[j].kodeBarang=kodeBrg) then
               begin
                   write('Jumlah Barang yang dibeli: ');readln(jmlBrg);
                   shopcart[idxCart].kodeBarang:=dtBarang[j].kodeBarang;
                   shopcart[idxCart].jmlBarang:=jmlBrg;
                   shopcart[idxCart].kodeBuyer:=Buyer[idxBuyer].KodeUser;
                   shopCart[idxCart].hargaTotal:=dtBarang[j].harga*jmlBrg;
                   dtBarang[j].Stok:=dtBarang[j].Stok-jmlBrg;
                   idxCart:=idxCart+1;
                   writeln('pembelian sukses');
               end;

       end;

       procedure bayarBarang(var shopcart:ShoppingCart;var Buyer:Users);
       var
        trf:longint;
       begin
           writeln('Kode Barang: ',shopcart[idxCart].kodeBarang);
           writeln('Kode Buyer: ',shopcart[idxCart].kodeBuyer);
           writeln('Jumlah Barang: ',shopcart[idxCart].jmlBarang);
           writeln('Total Harga: ',shopcart[idxCart].hargaTotal);
           writeln('-----------------------------');
           write('Silahkan Transfer(Harus sama dengan total harga): ');readln(trf);
           if (trf=shopcart[idxCart].hargaTotal) then
               begin
                   shopcart[idxCart].statusBayar:=true;
                   writeln('Transaksi Selesai');
               end
       else
               begin
                   write('Silahkan Transfer(Harus sama dengan total harga): ');readln(trf);
               end;

       end;



       procedure Menu();
       var
            pil,pil2,pil3:integer;
       begin
           writeln('SELAMAT DATANG DI TOKO ONLINE MAMPIRDULU');
           writeln('1. Registrasi');
           writeln('2. Login');
           writeln('3. keluar');
           write('Pilihan: ');readln(pil);
           while (pil<>0) do
           begin
               if (pil = 1) then
                   begin
                       writeln('1. Registrasi Seller');
                       writeln('2. Registrasi Buyer');
                       writeln('3. Kembali');
                       write('Pilihan: ');readln(pil2);
                       while (pil2<>0) do
                       begin
                           case pil2 of
                               1:
                                  begin
                                      writeln('Isi Data Seller');
                                      pendataanSeller();
                                      Menu();
                                  end;
                               2:
                               begin
                                   writeln('Isi Data Buyer');
                                   pendataanBuyer();
                                   Menu();
                               end;
                               3:
                               begin
                                   Menu();
                               end;
                       end;
                       end;
                   end
               else if (pil=2) then
                   begin
                     if(Login) then
                     begin
                         if(cekLoginSeller) then
                             begin
                                 writeln('1. Lihat Profil');
                                 writeln('2. Upload Barang');
                                 writeln('3. Logout');
                                 write('Pilihan: ');readln(pil3);
                                 while (pil3<>3) do
                                     begin
                                         case pil3 of
                                             1: begin
                                             profilSeller();
                                         end;
                                             2: begin
                                             tambahBarang(dtBarang,idxBarang);
                                             Menu();
                                         end;
                                             3: begin
                                             Menu();
                                         end;
                                     end;
                                     end;
                             end
                         else
                                 begin
                                     writeln('1. Lihat Barang');
                                     writeln('2. Beli Barang');
                                     writeln('3. Bayar');
                                     writeln('4. Logout');
                                     write('Pilihan: ');readln(pil3);
                                     while (pil3<>0) do
                                     begin
                                         case pil3 of
                                             1:begin
                                             tampilBarang(dtBarang,idxBarang);
                                         end;
                                            2: begin
                                            writeln('Masukkan kode barang: ');readln(kodebrg);
                                            beliBarang(shopcart,dtBarang,kodebrg,idxCart);
                                        end;

                                     end;
                                     end;
                                 end;
                             end
                         else writeln('Silahkan login dulu');

                         end
               else
                           begin
                               writeln('terima kasih');
                               readln;
                           end;
           end;
       end;

       begin
       clrscr;
           cekLoginBuyer  := false;
           cekLoginSeller := false;
           pendataanSeller();
           profilSeller();


        readln;
    end.
