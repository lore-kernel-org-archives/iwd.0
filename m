Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F673D6D
	for <iwd@lists.linux.dev>; Fri, 26 Aug 2022 14:02:03 +0000 (UTC)
Date: Fri, 26 Aug 2022 14:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vuqrsbb5zff5zjiiqcuxyie5ym.protonmail; t=1661522514; x=1661781714;
	bh=5XMNOlJBCo1RD/4rTDE4vRD21ODfPpIkdNNVyM0v+zw=;
	h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID;
	b=jyRXgt0IuWjbON6xUjJWPtL6jcwl0TNt8Ryin0aPStaFvhN+sRtdixnWOoqTtTMvd
	 sYJXCFUv7Fchuc7So/ZJMpEXC7+uJ5ed187YWrmnakYH4HL4SiFvcvp7uwZCDb5EhB
	 tTGydsApg/3FbrBRC/iqr6bdWnalCubnlsXZayIksQyPycvIGllfYzMi9ZVGkYHedU
	 sVU+YTtHtxNVd0r0kC1VPmGo1o7IMbevWbUBUT4Ud2v+LLuuuVLFerPqAsg2afuFch
	 0DGRGuklIvl6KihCaTohz8zMo2GlxmM/7u13UjhfyIp3LKmN1RY3PEYLNsCb8fgOJO
	 A9A64n088aeew==
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: bakerk98 <bakerk98@proton.me>
Reply-To: bakerk98 <bakerk98@proton.me>
Subject: Trouble with arm64 Pinebook Pro
Message-ID: <PTsiuiJUXgqE6WrNOYd6ijGXJVXO02MieWUrljZMKnDS9yvx1-HPGE_-SmsmhHSeSqmW_BNe5WHhrKeDLVxUAcFtkY8cfbI6GLiVMYLwZLI=@proton.me>
Feedback-ID: 51043915:user:proton
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello,

I am having an issue with iwd on my Pinebook Pro not recognizing the kernel=
 config completely. I have configured CONFIG_CRYTPO_MD4 and CONFIG_DH_KEY_O=
PERATIONS as Y in my kernel, but I am getting errors through iwd specifying=
 that features related to those 2 options, such as using MSCHAPV2 are disab=
led. iwd then recommends that I enable them in my kernel, but I have since =
verified and recompiled my kernel a couple of times with no luck.

Any help is greatly appreciated, and if I can include any extra information=
 I would be glad to.

Thanks
