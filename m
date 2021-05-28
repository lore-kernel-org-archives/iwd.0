Content-Type: multipart/mixed; boundary="===============1384065595038805932=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 1/3] network: sync known network frequency on BSS update
Date: Fri, 28 May 2021 13:33:52 +0000
Message-ID: <c02a8be1-0aaf-6cc2-4b62-73e6d6844f54@bang-olufsen.dk>
In-Reply-To: <17d72442-420e-fd56-3616-f99d5c52d099@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1384065595038805932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 5/28/21 3:13 PM, Denis Kenzior wrote:
> Hi Alvin,
> =

>>> All applied.=C2=A0 I did have to massage the formatting in patch 2 to f=
it
>>> into 80 columns.
>>
>> Thanks. And sorry about the formatting...
> =

> Generally checkpatch.pl from linux kernel would catch most of these.=C2=
=A0 We =

> do not allow mixed tabs and spaces, but my vim syntax highlighting =

> usually catches most of these...
> =

>>
>> I think it would be worth adding a .clang-format file to the project -
>> what do you think? As a starting point, the kernel's .clang-format seems
> =

> Hmm, you might have to educate me here.=C2=A0 Do note that we do not comp=
ile =

> with clang right now due to _auto_ fu in useful.h.

Despite the name, clang-format is just a code formatting tool. Or =

something like a glorified .editor-config. It reads a .clang-format =

configuration file and takes a .c/.h/etc. file as an input. It outputs =

the same file, reformatted according to the configuration. Most editors =

like Emacs/vim/etc. have support for it, maybe via plugins. Here's =

something for vim: https://github.com/rhysd/vim-clang-format

Just something to consider. But like I said, I could not figure out how =

to make it not use mixed tabs and spaces.

> =

>> pretty close already. The main difference seems to be that it uses
>> spaces after tabs to align parameters across multiple lines. I tried
>> unsuccessfully to persuade it not to use any spaces for alignment, but
>> I'm no expert.
>>
> =

> Right.=C2=A0 We have a few more house rules documented in doc/coding-styl=
e.txt.
> =

> Regards,
> -Denis

--===============1384065595038805932==--

