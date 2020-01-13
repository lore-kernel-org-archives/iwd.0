Content-Type: multipart/mixed; boundary="===============1742261898010169908=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Add a new frame watch API
Date: Mon, 13 Jan 2020 11:51:47 -0600
Message-ID: <9df24c78-6a56-be58-a7ea-b14fac7737ea@gmail.com>
In-Reply-To: <20200106123939.6960-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1742261898010169908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/6/20 6:39 AM, Andrew Zaborowski wrote:
> This new API is independent of netdev.c and allows actually
> unregistering from receiving notifications of frames, although with some
> quirks.  The current API only allowed the callback for a registration to
> be forgotten but our process and/or the kernel would still be woken up
> when matching frames were received because the kernel had no frame
> unregister call.  In the new API you can supply a group-id paramter when
> registering frames.  If it is non-zero the frame_watch_group_remove() call
> can be used to remove all frame registrations that had a given group-id
> by closing the netlink socket on which the notifications would be
> received.  This means though that it's a slightly costly operation.
> =

> The file is named frame-xchg.c because I'm thinking of also adding
> utilities for sending frames and waiting for one of a number of replies
> and handling the acked/un-acked information.
> ---
>   Makefile.am      |   1 +
>   src/frame-xchg.c | 476 +++++++++++++++++++++++++++++++++++++++++++++++
>   src/frame-xchg.h |  35 ++++
>   3 files changed, 512 insertions(+)
>   create mode 100644 src/frame-xchg.c
>   create mode 100644 src/frame-xchg.h
> =


Both applied, thanks.

Regards,
-Denis

--===============1742261898010169908==--

