Content-Type: multipart/mixed; boundary="===============8831403087989151721=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 03/13] handshake: add callback for extended key IDs
Date: Fri, 08 Oct 2021 08:48:29 -0500
Message-ID: <0895af1a-6dd6-9977-ba7e-29d12e7949f4@gmail.com>
In-Reply-To: 20211007204957.3745985-3-prestwoj@gmail.com

--===============8831403087989151721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/7/21 3:49 PM, James Prestwood wrote:
> The procedure for setting extended key IDs is different from the
> single PTK key. The key ID is toggled between 0 and 1 and the new
> key is set as RX only, then set to RX/TX after message 4/4 goes
> out.
> =

> Since netdev needs to set this new key before sending message 4,
> eapol can include a built message which netdev will store if
> required (i.e. using PAE).
> ---
>   src/handshake.c | 23 +++++++++++++++++++++++
>   src/handshake.h | 12 ++++++++++++
>   2 files changed, 35 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============8831403087989151721==--

