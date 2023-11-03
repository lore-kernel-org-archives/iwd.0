Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104A1A5B3
	for <iwd@lists.linux.dev>; Fri,  3 Nov 2023 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5Wu75o/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41e3e77e675so13243001cf.1
        for <iwd@lists.linux.dev>; Fri, 03 Nov 2023 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699031278; x=1699636078; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv/PGtXzMasg4zuhIm1pOCBgMidPQ4juqD5Ozh/CV7o=;
        b=C5Wu75o/f0kiAzoQxRZeK2SSTDUZBN0MT28invaQP7IklZZgzgqTIjj9D9rGTrG7Lt
         Vwg3mqItehnD2VrbFKHL8SqN66a4PGgq1ID4T5Tu7QuaBvN/xJtLsxOSYanL36RolUfl
         FKU/l2AkbgETgCnPvxrGEAVesc0BjxT0ADNudL3YOEsvPNzE77vjHrhZd0R3IvbqDAPK
         inubCiFuhEuWzrLqhAy5kxsY6BgyZQzrrq0imfPQ0Miv0gbx6w6rvQTgNGmB9fC9caR0
         +1aoVHJ3Bv3kIb7Sc6+jOo2i+YnGNm2TJxYSua5dlmKGlDmLkAK2hka2QdnbKu8v85p6
         l54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699031278; x=1699636078;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv/PGtXzMasg4zuhIm1pOCBgMidPQ4juqD5Ozh/CV7o=;
        b=OXshSmodTCS03CCbqyHgA0DGZ+B/TD0LEC9kG1D6vwZ1TjvV/Yygem54DebF/mLazE
         zlY3WZUDANc2gtG7ZR4HBB4LdTS8O4ccSSPoqLeWl46L0+IXBC3E7q5IpEqQVFgESCAf
         zLvidSZdXGZtYtFJ9cfT719Tj/DhXdJbC1gekVEoSFDcdudR1ALdoPP1KoAmcsCFzBUX
         2QCPE8rzgTA7y8i0KZrajc/SBjrs5H+/ihmYsEdtIxndbbiCr8AceotaOyIZCMTUZ/0m
         Nesn9Ap4uL7jE6FmCZbB52iUl4wHUcIxfN6FetGIHmRGbjKokWKO3ycoC6TqLhgAv5n2
         jyzw==
X-Gm-Message-State: AOJu0Yz2TBBENE1w8mBKoTFDsuUcfKnBVbr3puI2rMWPT2KssCzSMkmu
	XENUv/2UZ8635UgMjqi9rMQ+DcXKBxfrIL1v/Vc=
X-Google-Smtp-Source: AGHT+IFOXXP4i3d7NpZfezeL0Wp+asPdj3c19y2+TJjA+ioTAOUAWTF6Gkn1vt8772xkp735QwEJ03z6aV9e3ONb65k=
X-Received: by 2002:a05:622a:41:b0:41c:e92a:c611 with SMTP id
 y1-20020a05622a004100b0041ce92ac611mr24172009qtw.38.1699031277511; Fri, 03
 Nov 2023 10:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzCp0HZwBsoGM7i4k8v86JJWoDC7UDrEMsnqOoezKLcnyg@mail.gmail.com>
 <31c28e84-f3a7-4fb4-8ff3-a543c62bf2c2@gmail.com> <CA+iibzCmYAEOVo0EEiWKn9xWAQFMgSKFrJA8hffGEmLTxrsb-g@mail.gmail.com>
 <89efa890-4809-44b6-9ad4-1077294e3fd8@gmail.com> <CA+iibzAWVa+Tk995LwoTsVT8CTfQF=Ta6k6WYrrvX5DMLK5KZw@mail.gmail.com>
In-Reply-To: <CA+iibzAWVa+Tk995LwoTsVT8CTfQF=Ta6k6WYrrvX5DMLK5KZw@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Fri, 3 Nov 2023 18:07:46 +0100
Message-ID: <CA+iibzBTkjpn=y-+g9apLp0436mv8znD9SH7x4B9AsXQp-fNug@mail.gmail.com>
Subject: Re: iwctl interactive mode error
To: James Prestwood <prestwoj@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi gents

I have finally built iwd with readline. The problem was that readline
nead ncurses. The pkg-config file for ncurses is
/usr/lib/pkgconfig/ncursesw (or ncurses++w) and the compilation
requires /usr/lib/pkgconfig/ncurses.pc. By renaming ncursesw to
ncurses , the readline library is found and the compilation is fine.
Under readline iwctl is OK

antoine@grat-os1:~$ iwctl
NetworkConfigurationEnabled: disabled
StateDirectory: /var/lib/iwd
Version: 2.8
[iwd]#
ad-hoc         adapter        ap             debug          device
dpp            exit           help           known-networks quit
station        version        wsc
[iwd]# help

                               iwctl version 2.8
---------------------------------------------------------------------------=
-----
  Usage
---------------------------------------------------------------------------=
-----
  iwctl [--options] [commands]

                               Available options
---------------------------------------------------------------------------=
-----
  Options                                             Description
---------------------------------------------------------------------------=
-----
  --username                                          Provide username
  --password                                          Provide password
  --passphrase                                        Provide passphrase
  --dont-ask                                          Don't ask for missing
                                              credentials
  --help                                              Display help

                               Available commands
---------------------------------------------------------------------------=
-----
  Commands                                            Description
---------------------------------------------------------------------------=
-----

The screen is not garbled and autocomplete works without problem

The last version of libedit 20230828-3.1 seems to be the root of the
problem, I don't remember about the previous version 2022-10-30-3.1

Best regards

Daniel


Le ven. 20 oct. 2023 =C3=A0 19:28, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
>
> Hi Marcel and James
>
> As I have explain to james I have a problem with iwctl that doesn't
> work well in interactive mode.Several sessions of iwd seem to be open
> when I launch the iwctl command
>
> antoine@grat-os1:~$ iwctl
> Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
> [iwd]# NetworkConfigurationEnabled: disabled
> [iwd]# StateDirectory: /var/lib/iwd
> [iwd]# Version: 2.8^E
> [iwd]# n^^3_^E
>
> I am able to compile iwd with the option --enable-libedit.. I have
> just compiled the last commits. Iwd work without problems. I am not
> sure but I suppose we have upgraded libedit recently. So James asked
> me to try to compile with readline but the package readline is
> declared missing during the compilation.
> Is there a version detected for readline
>
> Best regards
>
> Daniel
>
> Le ven. 20 oct. 2023 =C3=A0 18:44, James Prestwood <prestwoj@gmail.com> a=
 =C3=A9crit :
> >
> >
> >
> > On 10/20/23 9:24 AM, daniel antoine wrote:
> > > Hi James
> > > Compile without the option --enable-libedit to use readline doesn't
> > > work. It doesn't find the readline package
> > >
> > > checking if gcc supports -fno-rtti -fno-exceptions... no
> > > checking for gcc option to produce PIC... -fPIC -DPIC
> > > checking if gcc PIC flag -fPIC -DPIC works... yes
> > > checking if gcc static flag -static works... yes
> > > checking if gcc supports -c -o file.o... yes
> > > checking if gcc supports -c -o file.o... (cached) yes
> > > checking whether the gcc linker (/usr/bin/ld -m elf_x86_64) supports
> > > shared libraries... yes
> > > checking whether -lc should be explicitly linked in... no
> > > checking dynamic linker characteristics... GNU/Linux ld.so
> > > checking how to hardcode library paths into programs... immediate
> > > checking whether stripping libraries is possible... yes
> > > checking if libtool supports shared libraries... yes
> > > checking whether to build shared libraries... yes
> > > checking whether to build static libraries... no
> > > checking for _init in -lasan... yes
> > > checking for _init in -llsan... yes
> > > checking for _init in -lubsan... yes
> > > checking for explicit_bzero... yes
> > > checking for rawmemchr... yes
> > > checking for reallocarray... yes
> > > checking for linux/types.h... yes
> > > checking for linux/if_alg.h... yes
> > > checking for readline... no
> > > configure: error: Readline library is required
> > > =3D=3D=3D=3D=3D=3D=3D> ERROR: Building
> > > '/usr/ports/perso/iwd/iwd1697817850x86_64.cards.tar.xz' failed.
> > > cards 2.6.4 create: could not parse Pkgfile: While running 'build()'
> > > root@grat-os1:/# cards search readline
> > > (base) readline 8.2 Set of libraries that offers command-line editing
> > > and history capabilities
> > > (base) readline.devel 8.2 Set of libraries that offers command-line
> > > editing and history capabilities
> > > (base) readline.doc 8.2 Set of libraries that offers command-line
> > > editing and history capabilities
> > > (base) readline.man 8.2 Set of libraries that offers command-line
> > > editing and history capabilities
> > >
> > >   the commit 8f0420c533ae6a49c4f2803afe32d5922a5236ad.seems to force
> > > libedit to be use
> > >
> > > I have tried to compile the version 2.7 of iwd without the option
> > > --enable-libedit and I have the same problem of readline missing
> > >
> > > checking if libtool supports shared libraries... yes
> > > checking whether to build shared libraries... yes
> > > checking whether to build static libraries... no
> > > checking for _init in -lasan... yes
> > > checking for _init in -llsan... yes
> > > checking for _init in -lubsan... yes
> > > checking for explicit_bzero... yes
> > > checking for rawmemchr... yes
> > > checking for reallocarray... yes
> > > checking for linux/types.h... yes
> > > checking for linux/if_alg.h... yes
> > > checking for readline... no
> > > configure: error: Readline library is required
> > > =3D=3D=3D=3D=3D=3D=3D> ERROR: Building
> > > '/usr/ports/perso/iwd/iwd1697818588x86_64.cards.tar.xz' failed.
> > > cards 2.6.4 create: could not parse Pkgfile: While running 'build()'
> > >
> > > root@grat-os1:/# cards search readline
> > > (base) readline 8.2 Set of libraries that offers command-line editing
> > > and history capabilities
> > > (base) readline.devel 8.2 Set of libraries that offers command-line
> > > editing and history capabilities
> > > (base) readline.doc 8.2 Set of libraries that offers command-line
> > > editing and history capabilities
> > > (base) readline.man 8.2 Set of libraries that offers command-line
> > > editing and history capabilities
> > >
> > > Is there a d=C3=A9tection for the version of readline . I add the PKG=
file
> > > of the 2.7 version
> >
> > That I'm not sure about. The Ubuntu version of libedit doesn't include
> > the right headers, and won't compile which is why I've avoided trying
> > it. If get some time I can try and build from source. If you don't have
> > libreadline as a package you may be stuck building from source as well.
> > IIRC Marcel added the libedit functionality, maybe see if he replies an=
d
> > can test it on his end?
> >
> > >
> > > Best regards
> > >
> > > Daniel
> > >
> > >
> > >
> > > Le ven. 20 oct. 2023 =C3=A0 15:48, James Prestwood <prestwoj@gmail.co=
m> a =C3=A9crit :
> > >>
> > >> Hi Daniel,
> > >>
> > >> On 10/20/23 6:37 AM, daniel antoine wrote:
> > >>> Hi gents
> > >>>
> > >>> After compiling iwd at the last commit I have tried to see the stat=
us
> > >>> of the network with the iwctl command. When I launch the command i
> > >>> have thisantoine@grat-os1:~$ iwctl
> > >>>
> > >>> Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
> > >>> [iwd]# NetworkConfigurationEnabled: disabled
> > >>> [iwd]# [iwd]# StateDirectory: /var/lib/iwd
> > >>> [iwd]# [iwd]# Version: 2.8
> > >>> [iwd]#
> > >>>
> > >>> The prompt [iwd]# is repeated several times and when I try to enter=
 a
> > >>> command I got this message
> > >>> Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
> > >>> [iwd]# NetworkConfigurationEnabled: disabled
> > >>> [iwd]# [iwd]# StateDirectory: /var/lib/iwd
> > >>> [iwd]# [iwd]# Version: 2.8
> > >>> [iwd]# station list
> > >>> bck:sta
> > >>>
> > >>> if I force the command it's worse
> > >>> Waiting for IWD to start...Waiting for IWD to start...[iwd]# [iwd]#
> > >>> [iwd]# NetworkConfigurationEnabled: disabled
> > >>> [iwd]# [iwd]# StateDirectory: /var/lib/iwd
> > >>> [iwd]# [iwd]# Version: 2.8
> > >>> [iwd]# station list
> > >>> [iwd]# s[iwd]# s                            Devices in Station Mode
> > >>>                          *
> > >>> [iwd]# s[iwd]# s---------------------------------------------------=
-------------------------------------------------
> > >>> [iwd]# s[iwd]# s  Name                  State            Scanning
> > >>>            ing
> > >>> [iwd]# s[iwd]# s---------------------------------------------------=
---------------------------------------------
> > >>> [iwd]# s[iwd]# s  wlan0                 connected
> > >>> [iwd]# s[iwd]# s
> > >>> [iwd]# s[iwd]# s[iwd]# s[iwd]# s stati[iwd]# stati
> > >>>
> > >>> It looks like the tab is active all the time and tries to send
> > >>> commands repeatedly . The screen is garbled and there is a click at
> > >>> each tab
> > >>>
> > >>> The result of a help command
> > >>> [iwd]# helpd]# s[iwd]# s[iwd]# s stati[iwd]# stati
> > >>> [iwd]# [iwd]#
> > >>> [iwd]# [iwd]#                                iwctl version 2.8
> > >>> [iwd]# [iwd]# -----------------------------------------------------=
---------------------------
> > >>> [iwd]# [iwd]#   Usage
> > >>> [iwd]# [iwd]# -----------------------------------------------------=
---------------------------
> > >>> [iwd]# [iwd]#   iwctl [--options] [commands]
> > >>> [iwd]# [iwd]#
> > >>> [iwd]# [iwd]#                                Available options
> > >>> [iwd]# [iwd]# -----------------------------------------------------=
---------------------------
> > >>> [iwd]# [iwd]#   Options                                            =
 Description
> > >>> [iwd]# [iwd]# -----------------------------------------------------=
---------------------------
> > >>> [iwd]# [iwd]#   --username
> > >>> Provide username
> > >>> [iwd]# [iwd]#   --password
> > >>> Provide password
> > >>> [iwd]# [iwd]#   --passphrase
> > >>> Provide passphrase
> > >>> [iwd]# [iwd]#   --dont-ask
> > >>> Don't ask for missing
> > >>>                                                 credentials
> > >>> [iwd]# [iwd]#   --help                                             =
 Display help
> > >>> [iwd]# [iwd]#
> > >>> [iwd]# [iwd]#                                Available commands
> > >>> [iwd]# [iwd]# -----------------------------------------------------=
---------------------------
> > >>> [iwd]# [iwd]#   Commands                                           =
 Description
> > >>> [iwd]# [iwd]# -----------------------------------------------------=
---------------------------
> > >>> [iwd]# [iwd]#
> > >>> Adapters:
> > >>> [iwd]# [iwd]#   adapter list
> > >>> List adapters
> > >>> [iwd]# [iwd]#   adapter <phy> show
> > >>> Show adapter info
> > >>> [iwd]# [iwd]#   adapter <phy> set-property <name> <value>          =
 Set property
> > >>> [iwd]# [iwd]#
> > >>> Ad-Hoc:
> > >>> [iwd]# [iwd]#   ad-hoc list
> > >>> List devices in Ad-hoc mode
> > >>> [iwd]# [iwd]#   ad-hoc <wlan> start <"network name"> <passphrase>
> > >>> Start or join an existing
> > >>> [iwd]# [iwd]#
> > >>> Ad-Hoc network called "network
> > >>> [iwd]# [iwd]#
> > >>> name" with a passphrase
> > >>> [iwd]# [iwd]#   ad-hoc <wlan> start_open <"network name">
> > >>> Start or join an existing open
> > >>> [iwd]# [iwd]#
> > >>> Ad-Hoc network called "network
> > >>> [iwd]# [iwd]#                                                      =
 name"
> > >>> [iwd]# [iwd]#   ad-hoc <wlan> stop
> > >>> Leave an Ad-Hoc network
> > >>> [iwd]# [iwd]#
> > >>> Access Point:
> > >>> [iwd]# [iwd]#   ap list
> > >>> List devices in AP mode
> > >>> [iwd]# [iwd]#   ap <wlan> start <"network name"> <passphrase>
> > >>> Start an access point called
> > >>> [iwd]# [iwd]#
> > >>> "network name" with a
> > >>> [iwd]# [iwd]#                                                      =
 passphrase
> > >>> [iwd]# [iwd]#   ap <wlan> start-profile <"network name">
> > >>> Start an access point based on
> > >>> [iwd]# [iwd]#                                                      =
 a
> > >>> disk profile
> > >>> [iwd]# [iwd]#   ap <wlan> stop
> > >>> Stop a started access point
> > >>> [iwd]# [iwd]#   ap <wlan> show                                     =
 Show AP info
> > >>> [iwd]# [iwd]#   ap <wlan> scan
> > >>> Start an AP scan
> > >>> [iwd]# [iwd]#   ap <wlan> get-networks
> > >>> Get network list after
> > >>> [iwd]# [iwd]#                                                      =
 scanning
> > >>> [iwd]# [iwd]#
> > >>> Devices:.......
> > >>>
> > >>> I am able to launch the command in non interactive mode without pro=
blem
> > >>> antoine@grat-os1:~$ iwctl ap list
> > >>>                             Devices in Access Point Mode
> > >>> -------------------------------------------------------------------=
-------------
> > >>>     Name                  Started
> > >>> -------------------------------------------------------------------=
-------------
> > >>> No devices in access point mode available.
> > >>> CY^E
> > >>> antoine@grat-os1:~$ iwctl dpp list
> > >>>                                 DPP-capable Devices
> > >>> -------------------------------------------------------------------=
-------------
> > >>>     Name
> > >>> -------------------------------------------------------------------=
-------------
> > >>>     wlan0
> > >>> ^T^XA\^E
> > >>>    but there is strange characters at the end of the command displa=
y
> > >>>
> > >>> There are no compilation errors. I send you my Pkgfile for iwd. I h=
ave
> > >>> tried to test with version 2.7 and it's the same.
> > >>>
> > >>> Libedit has been upgraded to version 20230828-3.1 I don't know if i=
t
> > >>> is related to.
> > >>
> > >> Could you try with libreadline? I never tested with libedit when it =
was
> > >> added, the packages were too old and didn't compile and I didn't bot=
her
> > >> building from source since others said it worked. I've never seen su=
ch a
> > >> problem myself with libreadline.
> > >>
> > >>>
> > >>> Best regards
> > >>>
> > >>> Daniel
