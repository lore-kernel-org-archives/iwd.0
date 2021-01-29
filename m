Content-Type: multipart/mixed; boundary="===============5902628447526833641=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4] knownnetworks: sanitize known_network.freq on load
Date: Fri, 29 Jan 2021 17:49:21 -0600
Message-ID: <4bcbe596-91fb-544e-dd4a-2ef60fd0e942@gmail.com>
In-Reply-To: <20210129234726.132679-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5902628447526833641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/29/21 5:47 PM, James Prestwood wrote:
> An invalid known_network.freq file containing several UUID
> groups which have the same 'name' key results in memory leaks
> in IWD. This is because the file is loaded and the group's
> are iterated without detecting duplicates. This leads to the
> same network_info's known_frequencies being set/overridden
> multiple times.
> =

> To fix this we just check if the network_info already has a
> UUID set. If so remove the stale entry.
> =

> There may be other old, invalid, or stale entries from previous
> versions of IWD, or a user misconfiguring the file. These will
> now also be removed during load.
> ---
>   src/knownnetworks.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> =

> v4:
>   * Fixed a few memory leak issues
> =


Applied, thanks.

Regards,
-Denis

--===============5902628447526833641==--

