Content-Type: multipart/mixed; boundary="===============1137966621077336780=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 07/12] dpp: add support for initiating as a configurator
Date: Thu, 20 Jan 2022 14:22:15 -0600
Message-ID: <81f8d5b7-5832-e6cc-6727-0db804a15e3c@gmail.com>
In-Reply-To: 20220118212512.2017977-7-prestwoj@gmail.com

--===============1137966621077336780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 1/18/22 15:25, James Prestwood wrote:
> The difference between the existing code is that IWD will send the
> authentication request, making it the initiator.
> =

> This handles the use case where IWD is provided a peers URI containing
> its bootstrapping key rather than IWD always providing its own URI.
> A new DBus API was added, ConfigureEnrollee().
> =


Is a patch for doc/device-provisioning-api.txt missing?

Regards,
-Denis
--===============1137966621077336780==--

