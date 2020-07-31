Content-Type: multipart/mixed; boundary="===============1971822555844408715=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/13] frame-xchg: Fix potential use after free
Date: Fri, 31 Jul 2020 10:40:51 -0500
Message-ID: <608dc79b-72b1-af67-c8c5-336662340329@gmail.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1971822555844408715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 7/30/20 8:31 PM, Andrew Zaborowski wrote:
> Check if the frame callback has cancelled the frame_xchg before
> attempting to free it.
> ---
> I'm adding a frame_xchg_match_ptr here and I think I might have
> used a similar function somewhere else.  I was wondering if we
> want to add a pointer compare function in util.c or accept NULL
> as match function in l_queue_find() to mean match by data pointer.
> ---
>   src/frame-xchg.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> =


Patches 1-10 applied, thanks.

Patch 11-13 refuse to apply for some reason, so please rebase/resend.

Regards,
-Denis

--===============1971822555844408715==--

