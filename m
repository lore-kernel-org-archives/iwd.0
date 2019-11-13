Content-Type: multipart/mixed; boundary="===============1134719828823516991=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [REQUEST] Is it possible to have PostUp exec hooks?
Date: Wed, 13 Nov 2019 12:50:23 -0600
Message-ID: <29a3121a-03bb-ca27-284a-2f8e0cebbada@gmail.com>
In-Reply-To: <157360342231.491299.16435010824605457499@fireY0ga>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1134719828823516991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/12/19 6:03 PM, genofire wrote:
> I really like to write some small scripts to set up my 464xlat clat
> after connecting.
> =


So in general it is actually not trivial support invoking arbitrary =

external scripts from a privileged process and do this securely.  Can be =

done, but it isn't really something we want to deal with inside iwd itself.

Another point against something like this is that such functionality can =

be easily accomplished by listening to a few D-Bus signals coming from =

iwd and invoking whatever script you care about.  If someone wants to =

contribute such a trivial script / daemon, we can certainly host it in =

the iwd git tree.

Regards,
-Denis
--===============1134719828823516991==--

