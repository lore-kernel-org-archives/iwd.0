Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFF1368
	for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 12:18:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4M42X53mMnz9sRk
	for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 14:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joachim-breitner.de;
	s=MBO0001; t=1660306133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GERbpBjd2wUWyJkUhdciRN3mERTVTApxvSFZimHMLbc=;
	b=w/AnjbWU08RVLgyQALQzpt+R9iAFwvMxRfnfFaFCwmz1Op9xKrfUZsYie3F0Mf+L7B9OfV
	nXtcvVzNI70STAYaocrjPG1spRQsLTTPHkaAQ06q7ttX2mkRpJ47KTNJ7hAMpVfJ+OwXVE
	/gkeEgLQzRRtHTmWtEorfhD1AyU2zFvYE7uehgthNULhVGMbMbhFPxuttoIa7RJ5uYFDZI
	IHt94EItQLG9QJzNdYKjw5DeSS8OJ0YdygmFh/lWBIvYhCp5WjkDYOfjdNT7OlKa5IWZPH
	WYWeU+23sdGqtO9IpECzsmqKZbduWVo5cR/Wi46LAp+EqFQ7HNnSppuJ9OVQ3A==
Message-ID: <f79517c3f23c14dcd6db0dd5f3fb48fdeb687315.camel@joachim-breitner.de>
Subject: iwd needs restart after suspending
From: Joachim Breitner <mail@joachim-breitner.de>
To: iwd@lists.linux.dev
Date: Fri, 12 Aug 2022 14:08:52 +0200
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4M42X53mMnz9sRk

Hi,

On my Lenovo Thinkpad X1 Carbon Gen 9 I observe that after suspending,
WLAN connectivity is gone,=A0and `iwctl station list` no longer shows any
devices. They come back with `systemctl restart iwd`.

I had this before upgrading to NixOS 22.05, but then it was fixed. But
it came up when I switched the kernel from 5.15 to 5.19. This is using
iwd-1.27.

Is this a known problem? If not, any information in particular I could
provide to fix it?

Cheers,
Joachim

(NB, also tracking this at https://github.com/NixOS/nixpkgs/issues/186274)



--=20
Joachim Breitner
  mail@joachim-breitner.de
  http://www.joachim-breitner.de/

