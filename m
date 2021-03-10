Content-Type: multipart/mixed; boundary="===============0661124983091609330=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] ap: Write extra frame IEs from the user
Date: Wed, 10 Mar 2021 16:48:03 -0600
Message-ID: <6e2605da-dfeb-7784-4017-90cafa909305@gmail.com>
In-Reply-To: <20210310220635.944104-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0661124983091609330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 3/10/21 4:06 PM, Andrew Zaborowski wrote:
> Add an API for the ap.h users to add extra IEs to outgoing management
> frames: beacons, etc.
> ---
> Changes in this version:
>   - a "client_frame" parameter is added to the callbacks so that the
>     ap_state API user can also react to IEs such as the P2P IE from
>     the client, and write its own IEs based on the contents.  The P2P
>     IE for example should only be in a Probe Response if the Probe
>     Request had one also.
>     I gave up on the idea of having multiple callbacks for multiple
>     frame types as in the end it is more limited.
>   - a single callback can be registered in the ap_ops structure,
>     dropped the method for dynamically registering those callbacks.
>   - buffers for the frames are l_malloc'd instead of being on the stack.
> =

>   src/ap.c | 107 +++++++++++++++++++++++++++++++++++++++++++++----------
>   src/ap.h |  23 ++++++++++++
>   2 files changed, 111 insertions(+), 19 deletions(-)
> =


This looks good to me.  I'm getting a compiler error after applying this pa=
tch =

though:

denkenz(a)localhost ~/iwd-master $ make
make --no-print-directory all-am
   CC       src/ap.o
src/ap.c: In function =E2=80=98ap_build_beacon_pr_tail=E2=80=99:
src/ap.c:597:6: error: =E2=80=98pr=E2=80=99 undeclared (first use in this f=
unction)
   597 |  if (pr) {
       |      ^~
src/ap.c:597:6: note: each undeclared identifier is reported only once for =
each =

function it appears in
make[1]: *** [Makefile:2239: src/ap.o] Error 1
make: *** [Makefile:1477: all] Error 2

Regards,
-Denis

--===============0661124983091609330==--

