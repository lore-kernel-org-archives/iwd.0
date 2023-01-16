Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2691363;
	Mon, 16 Jan 2023 07:39:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5607CDAF29;
	Mon, 16 Jan 2023 08:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1673854292; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xmuycNjBPrzlk9JO9HF7XDs4925GxI/7D4MHOLkf6P8=;
	b=TlZMq3wrOuq4VX+q4IkjLZzlNNsWQi/G3Z648xv3YqCpaoJqsQL9A9+rGmW1vumUPFRb32
	MOlWLcHsvfY03PZl7XLr8PEyc7Nv21Fl7+NOe4DXMgfInud7EnimPjJBRy9exienbR7Jru
	GqHb84aC0wMkrS3vFJPKEW75LjcgtU0Irb858NWloIrRQJmBFWOqgNvAurvCXl+PasIz5k
	H8BhiN4ANxxrxwzdrTH+fvRt5ifK81558/ABG4oAUKtGwtMtj+t7f4VZo+8oyKrJUpEIHd
	BjSRuakl8JGUyak44lV6VerZWLYSvy7MdUjIWu/u7Wvi7+Ps383ScfCPryUULQ==
Date: Mon, 16 Jan 2023 08:31:28 +0100
From: Daniel Wagner <wagi@monom.org>
To: Denis Kenzior <denkenz@gmail.com>
Cc: Jade Lovelace <lists@jade.fyi>, connman@lists.linux.dev,
	iwd@lists.linux.dev
Subject: Re: bug: 802.1x configuration is not turned into an iwd KnownNetwork
Message-ID: <20230116073128.u6oazqb5o3vvzp7b@beryllium.lan>
References: <CAFA9we_ArzwtDidQkEQTL-vEPC2GGnRTqZB7jbx=UZ-R1MkzoA@mail.gmail.com>
 <20230102082941.rhlb4dfwzhkvmav7@beryllium.lan>
 <cbf0c602-a854-bc24-a7ae-0eec05be86ec@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf0c602-a854-bc24-a7ae-0eec05be86ec@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Denis

On Tue, Jan 03, 2023 at 09:20:46AM -0600, Denis Kenzior wrote:
> > ConnMan interacts with iwd only via the D-Bus interface. I can't remember that
> > we added any code to do any provisioning in iwd (also a quick glance over the
> > iwd plugin code doesn't ring any bell). Also I couldn't find any API doc in iwd
> > which covers this topic. So I don't know if it is currently possible to
> > provision iwd via the D-Bus API.
> 
> There's no way to provision 802.1x networks over D-Bus.  However, connman
> can write provisioning files to iwd's storage dir (/var/lib/iwd typically)
> and iwd will pick these up.  This is what the NM backend does.

Thanks for the feedback. ConnMan has also no D-Bus API for provisioning a 802.1x
network. The user has to provide a config file for ConnMan for this use case as
too.

Not really sold on the idea to add code to copy over the config settings.

Thanks,
Daniel
