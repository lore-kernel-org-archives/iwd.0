Content-Type: multipart/mixed; boundary="===============6881285109996010116=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] eapol: prevent key reinstallation on retransmitted Msg4/4
Date: Wed, 12 Aug 2020 09:55:22 -0500
Message-ID: <cbae44c5-9f16-7acb-96ab-cedd46dcecd4@gmail.com>
In-Reply-To: <20200812111721.302407-1-Mathy.Vanhoef@kuleuven.be>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6881285109996010116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mathy,

On 8/12/20 6:17 AM, Mathy Vanhoef wrote:
> Currently an adversary can retransmit EAPOL Msg4/4 to make the AP
> reinstall the PTK. Against older Linux kernels this can subsequently
> be used to decrypt, replay, and possibly decrypt frames. See the
> KRACK attacks research at krackattacks.com for attack scenarios.
> In this case no machine-in-the-middle position is needed to trigger
> the key reinstallation.
> =

> Fix this by using the ptk_complete boolean to track when the 4-way
> handshake has completed (similar to its usage for clients). When
> receiving a retransmitted Msg4/4 accept this frame but do not reinstall
> the PTK.
> =

> Credits to Chris M. Stone, Sam Thomas, and Tom Chothia of Birmingham
> University to help discover this issue.
> ---
>   src/eapol.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============6881285109996010116==--

