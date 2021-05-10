Content-Type: multipart/mixed; boundary="===============8047798930103754858=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: ap mode problem
Date: Mon, 10 May 2021 16:27:53 -0700
Message-ID: <51ef6dbba033f3b57edc619817b0d6c7226998c7.camel@gmail.com>
In-Reply-To: <CAG17S_N_wNs17CCkr-fDoN4qdDCZZVSw1Yz4yRzzTFM4cJiPwQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8047798930103754858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,
> =


> I believe they are using GCC 10.2.0 as am I. I rebuilt the iwd-git
> AUR
> with the addition of the suggested 'disable-optimization'. I
> installed
> it and restarted the iwd service and get the same result with the
> test-eapol:
> ...
> TEST: EAPoL/FT-Using-PSK 4-Way Handshake
> TEST: EAPoL/Supplicant+Authenticator 4-Way Handshake
> test-eapol: unit/test-eapol.c:3698: eapol_ap_sta_handshake_test:
> Assertion `s.ap
> _success && s.sta_success' failed.
> Aborted (core dumped)

Intersting. I would have expected disable-optimization to fix this. I
am going to have to try this myself on the RPi I have. I have tried
GCC-9 on an RPi 3, but I will try 10 too, and if I still can't repro
I'll dig up the original Pi.

> =

> **BUT** now that I an using the latest iwd-git without optimizations
> and try to connect to it in AP mode, I connect. Also if I let connman
> use it as a tether, I also connect. If I re-build iwd-git 'with
> optimizations' and try again, it fails.
> =

> This is on an "Raspberry Pi Model B Plus Rev 1.2"

Well this is good, but also not too surprising. I was able to 'fix'
this problem while debugging by simply adding random debug prints
(small code changes can be enough to alter the binary and 'fix' the
issue). We are going to have to take another look here as our previous
fix apparently was not quite enough.

Thanks for your help with debugging.

James

> =

> Keith


--===============8047798930103754858==--

