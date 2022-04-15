Content-Type: multipart/mixed; boundary="===============7906346200444491374=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/4] dpp: handle sending a frame after ROC ends
Date: Fri, 15 Apr 2022 12:18:31 -0500
Message-ID: <313039da-7771-64ed-1cf2-7cb222efc0fa@gmail.com>
In-Reply-To: 20220415165921.9892-1-prestwoj@gmail.com

--===============7906346200444491374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/15/22 11:59, James Prestwood wrote:
> There is a potential corner case of an offchannel frame callback
> being called after ROC has ended.
> =

> This could happen in theory if a received frame is queued right as
> the ROC session expires. If the ROC cancel event makes it to user
> space before the frame IWD will schedule another ROC then receive
> the frame. This doesn't prevent IWD from sending out another
> frame since OFFCHANNEL_TX_OK is used, but it will prevent IWD from
> receiving a response frame since no dwell duration is used with DPP.
> =

> To handle this an roc_started bool was added to the dpp_sm which
> tracks the ROC state. If dpp_send_frame is called when roc_started
> is false the frame will be saved and sent out once the ROC session
> is started again.
> ---
>   src/dpp.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============7906346200444491374==--

