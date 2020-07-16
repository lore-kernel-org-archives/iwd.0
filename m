Content-Type: multipart/mixed; boundary="===============4344634069184056828=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] p2p: Implement the p2p.ServiceManager interface
Date: Thu, 16 Jul 2020 10:50:52 -0500
Message-ID: <92d3c9bb-df20-037a-e1e1-5c607195324d@gmail.com>
In-Reply-To: <20200716001227.311488-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4344634069184056828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 7/15/20 7:12 PM, Andrew Zaborowski wrote:
> The net.connman.iwd.p2p.ServiceManager interface on the /net/connman/iwd
> object lets user applications register/unregister the Wi-Fi Display
> service.  In this commit all it does is it adds local WFD information
> as given by the app, to the frames we send out during discovery.
> =

> Instead of accepting raw WFD IE contents from the app and exposing
> peers' raw WFD IEs to the app, we build the WFD IEs in our code based on
> the few meaningful DBus properties that we support and using default
> values for the rest.  If an app ever needs any of the other WFD
> capabilities more properties can be added.
> ---
>   src/dbus.h |   2 +
>   src/p2p.c  | 304 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 296 insertions(+), 10 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============4344634069184056828==--

