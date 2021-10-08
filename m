Content-Type: multipart/mixed; boundary="===============2540804791314174800=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 02/13] handshake: add flags/key index for extended key
 IDs
Date: Fri, 08 Oct 2021 08:46:50 -0500
Message-ID: <501b902c-1c0f-1fca-abe8-44a3de421dcc@gmail.com>
In-Reply-To: 20211007204957.3745985-2-prestwoj@gmail.com

--===============2540804791314174800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/7/21 3:49 PM, James Prestwood wrote:
> ext_key_id_capable indicates the handshake has set the capability bit
> in the RSN info. This will only be set if the AP also has the capability
> set.
> =

> active_tk_index is the key index the AP chose in message 3. This is
> now used for both legacy (always zero) and extended key IDs.
> ---
>   src/handshake.h | 2 ++
>   1 file changed, 2 insertions(+)
> =


I merged this patch with patch 8 since they seem to go logically together. =

Applied, thanks.

Regards,
-Denis

--===============2540804791314174800==--

