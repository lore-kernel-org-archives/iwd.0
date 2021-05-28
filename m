Content-Type: multipart/mixed; boundary="===============8073416709629963812=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] network: sync known network frequency on BSS update
Date: Fri, 28 May 2021 08:13:02 -0500
Message-ID: <17d72442-420e-fd56-3616-f99d5c52d099@gmail.com>
In-Reply-To: <b89215c0-e4f6-bcbf-f1b0-a82dcdf6668a@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8073416709629963812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

>> All applied.=C2=A0 I did have to massage the formatting in patch 2 to fit
>> into 80 columns.
> =

> Thanks. And sorry about the formatting...

Generally checkpatch.pl from linux kernel would catch most of these.  We do=
 not =

allow mixed tabs and spaces, but my vim syntax highlighting usually catches=
 most =

of these...

> =

> I think it would be worth adding a .clang-format file to the project -
> what do you think? As a starting point, the kernel's .clang-format seems

Hmm, you might have to educate me here.  Do note that we do not compile wit=
h =

clang right now due to _auto_ fu in useful.h.

> pretty close already. The main difference seems to be that it uses
> spaces after tabs to align parameters across multiple lines. I tried
> unsuccessfully to persuade it not to use any spaces for alignment, but
> I'm no expert.
> =


Right.  We have a few more house rules documented in doc/coding-style.txt.

Regards,
-Denis
--===============8073416709629963812==--

