Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D51C13
	for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 18:30:31 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so16538207pjm.1
        for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 10:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yWIwpb81Mqo27cqJiQ2pbj8l/yi5n3j84WVkiK7s6w=;
        b=l6WrKi1dA6bGlgTAQPWM2ggqvRNtbpmdNAujoqC2QayVQIRKoRfdegEeQGshn4ozdm
         XTVKSMz4Z9jXBuxdPI1dUNsA9p0CM6+X3HvO/hszqSRNFGF2us7DXJDFxMqxH/tTHowx
         aFVdIKpgpIa7iz29bf9Rp5aAf1CZEUwAOk7XUxI1vqVVA5MHXSn2yJLZeFwrWCLTUZ3M
         WLKLx3y1QGs9kEM3Y/7dWCkvjqscr4XXJqiCHg6lTfj2Vm64rkaCBAJINWu0DPZ6yCPA
         8lVkPzJE5XbP/PlNFGDOq0sAyOorKHgOqg8hs9RdsnknxFUR2hYUx3zFy4ZJJgWubZIa
         T8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6yWIwpb81Mqo27cqJiQ2pbj8l/yi5n3j84WVkiK7s6w=;
        b=HT7NxNSEh7XOkNsDri5c3akMc1M1rJ2WAVzl3hMEK5J5t9rwNBELBMr/Vz1/0+pHK5
         35xapt3F/J8SDeTSTEkB/FZWwUK18nc4FgXBy/31J6SCPlv5pJebcVaersiUb8enbIPP
         qFnaqzfUAMPs3WMXsQmcCjvV2nHDiL5qAHCHSz/uXv+lNnsh7JOTfuj4dQZSvegurWc0
         zxcmMMn9JNQekGRP2jNeSF0ksVIu8AVvf1CI48Q4hGyEMBW01d3vYv8OWuHo+Dhcr4b4
         jbxaQQEXYMsGpB4hkevYwEYyaX8haKr4y2jUGX6uSPCfLUhWphqjnfqYsEp8H3ouoU3E
         wL/Q==
X-Gm-Message-State: AFqh2kqyqIfbuUt34r6ypbzh4Rs7M0ASYi0tiM52AmiuXxaZ7gFlBdNU
	Tu9+6oM78KH9bEJEPJfD1v/n1Oic6+w=
X-Google-Smtp-Source: AMrXdXsE1PNWYtvbwO6tMUj+bsUk9A08sKDiyvB4x0FKV1b+m88cOoPadt3RnBnOuX+ksIEzAiMTcQ==
X-Received: by 2002:a17:902:f60b:b0:194:a663:675b with SMTP id n11-20020a170902f60b00b00194a663675bmr4416415plg.19.1673980231015;
        Tue, 17 Jan 2023 10:30:31 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902bb8c00b00172b87d9770sm3399595pls.81.2023.01.17.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 10:30:30 -0800 (PST)
Message-ID: <37fe77f33fe8eed72edde3e1d5ce1ca3509dc63d.camel@gmail.com>
Subject: Re: iwd fails to create device
From: James Prestwood <prestwoj@gmail.com>
To: Kevin Boulain <kevin@boula.in>, iwd@lists.linux.dev
Date: Tue, 17 Jan 2023 10:30:29 -0800
In-Reply-To: <20230115155302.14317-1-kevin@boula.in>
References: <2fec88f46974c051e5b4c277b50d2ae88c2fe5e5.camel@gmail.com>
	 <20230115155302.14317-1-kevin@boula.in>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Kevin,

On Sun, 2023-01-15 at 16:53 +0100, Kevin Boulain wrote:
> > This looks very familiar to an issue we fixed with dual-phy cards,
> > but
> > this isn't the case for you. Its as if your phy is being detected
> > twice.
> 
> It doesn't look like the OP has followed up on this but it seems I have
> a very similar issue. It appears that when iwd (2.0) starts and the
> kernel (6.1.3) reports Bluetooth/iwlwifi stuff right after it, iwd will
> see the same interface twice and my wlan0 interface won't come up.
> Restarting iwd fixes the issue.

Would you be able to try the last two patches on the list? The archive
link is:

https://lore.kernel.org/iwd/20230117180343.1451626-1-prestwoj@gmail.com/T/#t

Hopefully this fixes the problem.

Thanks,
James


