Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F5748C
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 17:23:54 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id p24so513559plw.1
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2g6PuIBKP9MWU6U3dZFhw/XD30EQH1AaPpKFdPFVUTs=;
        b=GzsQV0nT/OpjU0CZTyYeBlChq3Z6eVG7utH91fPfqebjpy/EpkZbk3XwZ0sgPeIShW
         ATgt4yCQPcn7SnuRVFqQZ3Xf47T/uOAnAOTRAH4rRe7h+ViUgWM5R12yprPFyANx6EZE
         Q0qJGvSg91uy+JC0wuWwRUHUEPs9OfQnjEdLWqHeUSA/a2cl9kCJLOngIa6Ds+hRLMZx
         B6itmg0/sKLSap2QS8ftXWER++dqy+YKM9ftpydUcDqKh3dSyDwVO5oEyTsLQ61h7zO7
         waJWulsL7zakzchyaaS4o5IOjAIhUBJVEA0EhaaeA3g7jFSDfEo50v2tk5+lxqcyjxM6
         XbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2g6PuIBKP9MWU6U3dZFhw/XD30EQH1AaPpKFdPFVUTs=;
        b=4oBF6rDK2plsDWw76tEB5ylkapVCUMzxbOn2k/Pz+xjHnmpNZSG+3voLxxZ8Klu7Os
         WFH4KzIywfGFMZ3E4D1m5cE39UrRh/81Nwf769fIWF7dogeLRnHbrPXvRMo6nG+IrW3q
         tEF0XiAbLWC9RwGO2BNJElacCHC5LbyH1U0m6OE+opK0+x7FMnc2VDpeIwNoKi8x2EF7
         tx6hQK1WKb19uHcO74kkmEr430x5RhNq5hiaKa8EyoP6PLbZHl5HT3vh4rQdA8WRO18J
         qzbU6AfKY0P+v07fFgjZOg6rIC9TjqldMQGer6dxd7mBB0kDDNSHtavlyeYTas4/XjKY
         J1dQ==
X-Gm-Message-State: ANoB5plKC4lARndEkRWLZV/aj3WcpojNUL0RyADKKXNel8x74vBgP+2+
	ynbD3gQ6oQkflozxRTHFWxE=
X-Google-Smtp-Source: AA0mqf5gI2AEBFESl5LhfYJD680mLAMv1WAiXmY1Z7AFp3Iq1rQluniB51NCGoioEvOLgUpVFPbIgQ==
X-Received: by 2002:a17:902:8a87:b0:189:86ec:e4db with SMTP id p7-20020a1709028a8700b0018986ece4dbmr19951895plo.14.1670952233969;
        Tue, 13 Dec 2022 09:23:53 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 192-20020a6307c9000000b00476799699e4sm7137240pgh.30.2022.12.13.09.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:23:53 -0800 (PST)
Message-ID: <59639a626260a24147be730f9703e0d766bd5f1b.camel@gmail.com>
Subject: Re: iwd release 1.30 onwards cannot find available networks
From: James Prestwood <prestwoj@gmail.com>
To: Bruno Dantas <dantas@airpost.net>, Alvin =?UTF-8?Q?=C5=A0ipraga?=
	 <ALSI@bang-olufsen.dk>
Cc: Denis Kenzior <denkenz@gmail.com>, "iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Tue, 13 Dec 2022 09:23:52 -0800
In-Reply-To: <615ceb63-e041-1990-81fa-568181681aa7@airpost.net>
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
	 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
	 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
	 <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
	 <5056edba-fa23-b133-73ac-f8daa483cf23@airpost.net>
	 <20221212193846.ub2ahzpl5eu2ylnu@bang-olufsen.dk>
	 <615ceb63-e041-1990-81fa-568181681aa7@airpost.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Bruno,

On Tue, 2022-12-13 at 09:42 -0500, Bruno Dantas wrote:
> Hi, Alvin. 
> 
> Thank you for looking into this issue. 
> 
> I just wanted to report that latest commit
> (ed357d78b3c70c43b37ec9444f5c96f14e14eb88) has not solved the bug I'm
> experiencing. "station wlan0 scan" continues to either hang
> indefinitely or say "Operation already in progress". "station wlan0
> get-networks" continues to claim that no networks are available, which
> is not true. This behavior unfortunately makes iwd unusable in my place
> of work.

Maybe you missed Denis' email, but I've sent a patch that will
hopefully fix your problem. Its on the list, or archives:

https://lore.kernel.org/iwd/20221212220857.1284874-1-prestwoj@gmail.com/T/#u

> 
> If you guys need any further information or debug logs to solve this,
> please let me know and I'll be happy to help.
> 
> Cheers,
> Bruno


