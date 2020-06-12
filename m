Content-Type: multipart/mixed; boundary="===============3312422953930322835=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] network: delay connect if ANQP has not completed
Date: Fri, 12 Jun 2020 12:48:13 -0500
Message-ID: <ff93aa8e-3606-e02d-6a16-e24e1c4a5e12@gmail.com>
In-Reply-To: <20200612162025.6996-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3312422953930322835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/12/20 11:20 AM, James Prestwood wrote:
> Using the new station ANQP watch network can delay the connection
> request until after ANQP has finished. Since station may be
> autoconnecting we must also add a check in network_autoconnect
> which prevents it from autoconnecting if we have a pending Connect
> request.
> ---
>   src/network.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> =

> v2:
>   - Moved most of the logic out of _connect_8021x and into the ANQP watch
>     callback. Setting connect_after_anqp to NULL was still required though
>     because if an agent request is needed this could let autoconnect
>     try and connect to a network. This is checked for in network_autoconn=
ect
>     but only if connect_after_anqp is non-NULL. So we wait until the last
>     possible moment to NULL that.
> =


Sorry I couldn't make up my mind yesterday as to which way to go in canceli=
ng =

remaining ANQP requests on connect or not.

This series looks good, but I'm not sure why you'd treat 'connect_after_anq=
p' =

differently than a regular connect request over d-bus.  Those can come in d=
uring =

autoconnect phase and can still get stuck in the 'agent limbo'...

By the way, it might also warrant a WARN_ON if we ever hit the

+	if (network->connect_after_anqp)
+		return -EALREADY;
+

condition inside network_autoconnect().  Since it really shouldn't happen a=
nd is =

likely a bug in station if it did.

Regards,
-Denis
--===============3312422953930322835==--

