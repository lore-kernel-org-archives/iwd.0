Content-Type: multipart/mixed; boundary="===============8294508451660722176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] client: Fix proxy object's dependency resolution
Date: Fri, 07 Feb 2020 15:25:12 -0600
Message-ID: <acc68893-fc74-d3e1-ae05-40997e2d2469@gmail.com>
In-Reply-To: <20200207211122.24801-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8294508451660722176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 2/7/20 3:11 PM, Tim Kourt wrote:
> Previously, the parsing of the OMs objects has been done in one pass,
> therefore, the proxy object's dependencies may not have been parsed at the
> time when they were looked up for the dependency assignments. Now, the
> parsing of the OM objects is done in two passes: 1) Create proxy objects -
> one per interface and path, 2) Populate the proxy objects with properties
> and assign dependencies. Therefore, we are guaranteed to have the proxy
> objects created by the time they are looked up for the dependency
> assignments.
> ---
>   client/dbus-proxy.c | 99 ++++++++++++++++++++++++++++++++++------------=
-------
>   1 file changed, 63 insertions(+), 36 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8294508451660722176==--

