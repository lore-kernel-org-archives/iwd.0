Content-Type: multipart/mixed; boundary="===============7960178241157458890=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 30 Nov 2021 16:01:49 -0600
Message-ID: <d899ecf8-deb2-f526-c20f-0fd80aba9841@gmail.com>
In-Reply-To: CAA=hcWSGuuPcXbt6M=SOBmC+wYmPxMseG8veBgK9PUP8Or-bpA@mail.gmail.com

--===============7960178241157458890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jupiter,

>                                 Available networks
> -------------------------------------------------------------------------=
-------
>      Network name                    Security          Signal
> -------------------------------------------------------------------------=
-------
>      JupiterIoT                      psk               ****
> =

> # station wlan0 connect JupiterIoT
> Type the network passphrase for JupiterIoT psk.
> Passphrase: superpassphrase
> Operation aborted
> =


Are you running connman + iwd?  Are you sure ConnMan isn't aborting the =

connection?  Have you tried using connmanctl or using iwd + iwctl with conn=
man =

not running?

We do need iwd logs and preferably iwmon logs.  You may need to build nlmon =

support into your kernel if iwmon doesn't start.  e.g. CONFIG_NLMON=3Dm or y

Regards,
-Denis
--===============7960178241157458890==--

