Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B627C;
	Mon, 24 Apr 2023 05:54:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5B33DE350;
	Mon, 24 Apr 2023 07:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1682315196; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+9P6QoOlDUQFIv5bvziiKeXI0iRiSG5cAa/wG7Oi254=;
	b=GXSG7l7SNMLemWvpVP1YCFnRJBL5rUHRGHfWLIeoycY7dAuK/WkB2r1JKUstJoFHTKdCYw
	NiRG4fgbSaLIwdzncssUxU8EGWzvBS/9WhKuud+XWQWqTlnZPv9+HYXIXgzOY0m5VE3WKp
	rzhovQsBxT64poUu0aSFN6O940UgL2NMM2rAda/Jh5ZOyfiJPycRiRAxqBFGO0TNPhtpns
	RQ3N84FjGb3Bzhl2mJiNA1/J9tjLRvVZ+8eeE7rKsLGf15JscTJHFHVC5jyVwLBIhLgfM6
	A1NOxXgEgJpgdXOtgzqoaDOGlDhVPk0bEnyjG4WR5tIwe/mbQLigrY4I7mtueQ==
Date: Mon, 24 Apr 2023 07:46:35 +0200
From: Daniel Wagner <wagi@monom.org>
To: daniel antoine <univac55@gmail.com>
Cc: connman@lists.linux.dev, iwd@lists.linux.dev
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
Message-ID: <zp2pcpoqip7qkqhzrgjd2v55yhfqfpv7qke63njyocpuphrgz7@vto2ce7jzm4g>
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Add iwd mailing list

On Sat, Apr 22, 2023 at 05:03:00PM +0200, daniel antoine wrote:
> I have tried to build iwd to the last commit "Allow building with
> libedit instead readline". The Pkgfile seems to need the option
> --enable-libedit to remove readline but it fails with
>   CC       wired/dbus.o
>   CCLD     ell/libell-internal.la
>   CCLD     client/iwctl
>   CCLD     src/iwd
>   CCLD     wired/ead
> /usr/bin/ld: client/command.o: in function `command_completion':
> command.c:(.text+0x6cc): undefined reference to `rl_copy_text'
> /usr/bin/ld: command.c:(.text+0x8b0): undefined reference to `rl_copy_text'
> /usr/bin/ld: client/display.o: in function `save_input':
> display.c:(.text+0x32): undefined reference to `rl_copy_text'
> /usr/bin/ld: display.c:(.text+0x3a): undefined reference to `rl_save_prompt'
> /usr/bin/ld: display.c:(.text+0x46): undefined reference to `rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_text':
> display.c:(.text+0x796): undefined reference to `rl_restore_prompt'
> /usr/bin/ld: display.c:(.text+0x7a0): undefined reference to `rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_completion_matches':
> display.c:(.text+0x834): undefined reference to `rl_copy_text'
> /usr/bin/ld: client/display.o: in function `timeout_callback':
> display.c:(.text+0x9d0): undefined reference to `rl_restore_prompt'
> /usr/bin/ld: display.c:(.text+0x9da): undefined reference to `rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_table_footer':
> display.c:(.text+0x11a6): undefined reference to `rl_restore_prompt'
> /usr/bin/ld: display.c:(.text+0x11b1): undefined reference to `rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_enable_cmd_prompt':
> display.c:(.text+0x168e): undefined reference to `rl_save_prompt'
> /usr/bin/ld: display.c:(.text+0x1698): undefined reference to
> `rl_restore_prompt'
> /usr/bin/ld: client/display.o: in function `display_agent_prompt':
> display.c:(.text+0x177d): undefined reference to `rl_copy_text'
> /usr/bin/ld: display.c:(.text+0x1797): undefined reference to `rl_replace_line'
> /usr/bin/ld: display.c:(.text+0x17a5): undefined reference to
> `rl_erase_empty_line'
> /usr/bin/ld: client/display.o: in function `display_agent_prompt_release':
> display.c:(.text+0x1889): undefined reference to `rl_copy_text'
> /usr/bin/ld: display.c:(.text+0x18cd): undefined reference to
> `rl_erase_empty_line'
> /usr/bin/ld: display.c:(.text+0x18db): undefined reference to `rl_replace_line'
> /usr/bin/ld: client/display.o: in function `display_init':
> display.c:(.text+0x1a3e): undefined reference to `rl_erase_empty_line'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:1895: client/iwctl] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1595: all] Error 2
> =======> ERROR: Building
> '/usr/ports/perso/iwd/iwd1682174379x86_64.cards.tar.xz' failed.
> 
> It looks like some readline commands are always taken in count
> 
> I have my Pkgfile and the compilation log
> 
> 
> best regards
> Dania



