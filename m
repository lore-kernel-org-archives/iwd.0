Content-Type: multipart/mixed; boundary="===============6655612655227040049=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: DHCP renewal
Date: Mon, 28 Jun 2021 12:32:09 -0500
Message-ID: <0bb0db6b-8822-46c8-64b7-e1106b4a52e5@gmail.com>
In-Reply-To: <CACsRnHX=ThO+5zbScLLDdwJB8WOEEtkMdA1LmZsh8TttZZsw9w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6655612655227040049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 6/28/21 12:08 PM, Michael Johnson wrote:
> Hi all,
> =

> I'm having a problem with the DHCP component=C2=A0of iwd whereby I have i=
t sending =

> the initial request and getting the IP fine but when it comes time for re=
newal =

> (in my case after 1 hour) then there is an error and the DHCP lease is le=
ft to =

> expire. Turning on the IWD_DHCP_DEBUG flag I get this output:
> =

> Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:626
> Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:628 En=
tering =

> state: DHCP_STATE_RENEWING
> Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_send_request:394
> Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_t1_expired:633 Se=
nding =

> request failed: Socket operation on non-socket

This implies that the socket used for the unicast wasn't opened properly.

Try stracing / logging what happens in _dhcp_default_transport_bind().  May=
be =

one of the sockopts we try to set on the socket is not available?

> Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] dhcp_client_send_release:487
> Jun 28 14:46:25 p3-1337 iwd[7281]: [DHCPv4] l_dhcp_client_stop:1199 Enter=
ing =

> state: DHCP_STATE_INIT
> =

> Does anyone know what might be causing this? I'm still learning the code =
base =

> but I don't see anything obvious=C2=A0wrong (and I can't be sure this isn=
't a problem =

> with my system).
> This is with the latest master build of both iwd and ell.
> =

> =


Regards,
-Denis
--===============6655612655227040049==--

