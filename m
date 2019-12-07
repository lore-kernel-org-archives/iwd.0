Content-Type: multipart/mixed; boundary="===============0410369448180184279=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Suggestion: make iwctl follow the XDG Base Directory Specification
Date: Sat, 07 Dec 2019 16:47:39 +0100
Message-ID: <B4E8E87E-8EE1-4487-AEFA-59EC699A3FE9@holtmann.org>
In-Reply-To: <20191207104713.2883.96138@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0410369448180184279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Currently iwctl writes its history to a file named .iwctl_history in the =
users home directory. The XDG Base Directory Specification tries to standar=
dize these kind of things (see https://specifications.freedesktop.org/based=
ir-spec/basedir-spec-latest.html for details). The bottom line would probab=
ly be to:
> * check XDG_DATA_HOME (with fall back to .local/share/) and save the hist=
ory in an iwd subfolder of that directory
> * potentially read (and migrate?) .iwctl_history from the home directory =
for compatibility purposes

I am fine with using $XDG_DATA_HOME/iwctl/history or $HOME/.local/share/iwc=
tl/history as fallback if $XDG_DATA_HOME is not provided. Care to send a pa=
tch for this?

Regards

Marcel

--===============0410369448180184279==--

