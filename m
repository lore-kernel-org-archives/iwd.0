Content-Type: multipart/mixed; boundary="===============5537643846953231788=="
MIME-Version: 1.0
From: Joseph Benden <joe at benden.us>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/7] storage: implement network profile encryption
Date: Fri, 04 Feb 2022 15:55:32 -0700
Message-ID: <e7e5a0d3-5cfd-be0d-c847-22e91e856e64@benden.us>
In-Reply-To: 20220203212337.120613-1-prestwoj@gmail.com

--===============5537643846953231788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

It is my understanding that all secret data is to be kept as securely as =

possible. I'm not really seeing this carried throughout the source code. =

Maybe this specific code does not need that level of security?

If I'm right, then:

The secret data should be kept in a mmap(), and mlock(), structure. The =

prevents secret data from hitting swap memory. After every use of the =

secret data; it must be explicit_bzero() and then free(). This is so =

critical and tedious that it should be a macro or something from libell. =

And those are just initial thoughts for the basic safety of the secret data.

Best regards,
-Joe

--===============5537643846953231788==--

