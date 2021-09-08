Content-Type: multipart/mixed; boundary="===============2013650759849925631=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/5] sae: don't send commit/confirm in confirmed state
Date: Wed, 08 Sep 2021 16:48:32 -0500
Message-ID: <1fdeae1b-4015-5476-07c4-84366061ff9f@gmail.com>
In-Reply-To: <20210908213201.97115-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2013650759849925631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 4:31 PM, James Prestwood wrote:
> This works around a hostapd bug (described more in the TODO comment)
> which is exposed because of the kernels overly agressive re-transmit
> behavior on missed ACKs. Combined this results in a death if the
> initial commit is not acked. This behavior has been identified in
> consumer access points and likely won't ever be patched for older
> devices. Because of this IWD must work around the problem which can
> be eliminated by not sending out this commit message.
> =

> This bug was reported to the hostapd ML:
> =

> https://lists.infradead.org/pipermail/hostap/2021-September/039842.html
> =

> This change should not cause any compatibility problems to non-hostapd
> access points and is identical to how wpa_supplicant treats this
> scenario.
> ---
>   src/sae.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> =


Patches 1-3 and 5 applied, thanks.

Regards,
-Denis

--===============2013650759849925631==--

