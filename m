Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15179C9
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 22:05:34 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id f63so2859133pgc.2
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LVlRzO2wnOQ1w5t/vctHSdZFsvS958U/pimUkbBsSTY=;
        b=h0NFyQXIY3rQIYW1m/ajTGCj7dc4w/tmvIOITJK2NtTRVeTfuJEuLaiviDtQ0ElqOx
         6Dd3tpiY+XAAlAcQ+U7wf5FZ/08gLEkNSNiQZ6eq4rfVhjH9zl9V6pjOS5QJuYvVMWCo
         rmzbq3zx+djA1wyXQSX5rzR7T1XaMVKZGJFgmWH1/jiLSewrgoXB6h9L517ERauvz6jC
         Fgk1q2jSflUPpM3+C0U5x3NoI9bhzlGMVz85SNYzbiQOuQW7RwErJiMBLO90+a/Wot0j
         IIbLSgiYxX4063Cp5OvZ7RRP0bnWz7bakyr12hFTePa9qc8ppERi+181+8w1rzPDBu9e
         9S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVlRzO2wnOQ1w5t/vctHSdZFsvS958U/pimUkbBsSTY=;
        b=rVwjav/ru9lUzTtxGitPbe6KBRNYXkKOj5ZwVCLQXoC4CI+qbAMguC4SczCkoRYMn8
         G4JaucopKFsEca5Npt5p/cRJ8uJjsZvq+rvOmsgSeS9oAuvoVxheST/c9KQmkx9h9/Ha
         /3usH+VNpvQHWZ0FXrRZkbMfpoWarWVGwoplLb8I/YUx+sMoJ6ECidcacmpaCvCwV8sC
         hmJbq0q78dZp4TflVCrgNo3dGzI/RWEsn+JhEIk3p8DJGOkZFtfY7WF082u+UJxH4NLJ
         hauSeADGAe67DJ6PIYP8NB0pKuvRv7KNRomaDbGybZlchY8HswXtaxBzQgxNV22tr69l
         nqMA==
X-Gm-Message-State: ACrzQf2aeMJebDv0cuJjdH0KLjIs+VZYRFpFI7AVRh4Yj6eIPylSQNc8
	0J/4Usx/8DMkWFm/Xjn+7JQ=
X-Google-Smtp-Source: AMsMyM4BQdKqD2if3rmZr+OZl0HYkuxFVQFbq12kHdbefazrtzUBrvjf+m0AlGAODCy5YdI4cc6VaQ==
X-Received: by 2002:a05:6a02:186:b0:431:25fb:f1fe with SMTP id bj6-20020a056a02018600b0043125fbf1femr28480638pgb.130.1667513133760;
        Thu, 03 Nov 2022 15:05:33 -0700 (PDT)
Received: from [192.168.254.95] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0017f74cab9eesm1152194plg.128.2022.11.03.15.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:05:33 -0700 (PDT)
Message-ID: <6aef1f2eb02d0e2d80451a207ef80f35001f7367.camel@gmail.com>
Subject: Re: [PATCH 2/2] doc: document global MulticastDNS option
From: James Prestwood <prestwoj@gmail.com>
To: Andrea Pappacoda <andrea@pappacoda.it>, Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Date: Thu, 03 Nov 2022 15:05:32 -0700
In-Reply-To: <B2LSKR.D7EWT15BQHCU@pappacoda.it>
References: <20221103105639.8289-1-andrea@pappacoda.it>
	 <20221103105639.8289-2-andrea@pappacoda.it>
	 <5aca9b77-5c66-7744-8e33-a0578b645408@gmail.com>
	 <5TJSKR.MEMQ5IPV9F42@pappacoda.it> <B2LSKR.D7EWT15BQHCU@pappacoda.it>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2022-11-03 at 22:58 +0100, Andrea Pappacoda wrote:
> Hi again,
> 
> Il giorno gio 3 nov 2022 alle 22:31:53 +01:00:00, Andrea Pappacoda 
> <andrea@pappacoda.it> ha scritto:
> > As far as I understand, when no link-specific value is provided on 
> > the D-Bus interface, resolved sets LLMNR to "yes"[1] and mDNS to 
> > "no"[2]. It is possible that I have misinterpreted the code though,
> > so checking if this is actually the case could still be worth it.
> 
> Thinking about this more, I'm starting to see this as a bug in 
> systemd-resolved. I've reported it on 
> <https://github.com/systemd/systemd/issues/25252>.
> 
> For the time being, it may be better not to merge this.

In addition the documentation about calling with an empty string
doesn't appear to be true either. If I set main.conf:

[Network]
MulticastDNS=


And modify the logic to allow "" I both don't see +mDNS on my per-link
setting, nor do I see any mDNS packets.

So I guess we see what systemd says, I'll also comment on that bug
report about the empty string issue. Maybe you could try this out as
well to make sure I'm not crazy.

Thanks,
James

