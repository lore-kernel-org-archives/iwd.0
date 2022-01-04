Content-Type: multipart/mixed; boundary="===============1943541002418122759=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/6] auto-t: wpas.py: don't require strict match on
 wait_for_event
Date: Tue, 04 Jan 2022 12:03:58 -0600
Message-ID: <edaf9497-fadf-dfb3-a1ce-7ab6a8b84692@gmail.com>
In-Reply-To: 20220104181857.103331-1-prestwoj@gmail.com

--===============1943541002418122759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/4/22 12:18, James Prestwood wrote:
> wait_for_event was checking the event string presence in the rx_data
> array which meant the event string had to match perfectly to any
> received events. This poses problems with events that include additional
> information which the caller may not be able to know or does not care
> about. For example:
> =

> DPP-RX src=3D02:00:00:00:02:00 freq=3D2437 type=3D11
> =

> Waiting for this event previously would require the caller know src, freq,
> and type. If the caller only wants to wait for DPP-RX, it can now do that.
> ---
>   autotests/util/wpas.py | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============1943541002418122759==--

