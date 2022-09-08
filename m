Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AD46BA
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 17:31:26 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id t65so6474828pgt.2
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=ZNMLhcVERfC15Qae1Kmy/GWzEJYE8yeCb4ydySV59uA=;
        b=ldEf2QNjkCP8J8reql+gH4ZjDs9SKkdX1OcxKouRuxfy/u0ptwHKtueS8/E/mFgkzm
         JrAEfHneUj+xQJAH51B6f7cHyBIU5bs4DC3u1ufDlMN93+anVXTSUQG44pNKZDgiB3tw
         e6lq0ny3KvbuLoNIR5CV29rNTR9FJnoGhJ4gyTJkeyZrUB/1Z/R7jeruanjAPcQQJH99
         3caPwDnPF2uhFhrKz0jjB+cifisWSf89i9/El0vuBOeXNSaeBdjofpcn7vl6DwuRFxhO
         VTcbO9+KUYt2iRdYTIgBDNcKbGas4U7e2tWFGpbREGTLtDA4dUGOHymD1H09Zu6jE7wx
         IKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ZNMLhcVERfC15Qae1Kmy/GWzEJYE8yeCb4ydySV59uA=;
        b=WpMSIFGnIzg019AD8VkkgTVe32M5VE8Qbzt/Sd9m5bfWmc1CkCLrhv1YQRnuNbrd5x
         zayTBeoBAq2161mLIRRYNNtlA8Q/nkqDE9gHsPWbD8B+vY8reBY4cb9fNFITfC4pv4U8
         nBxFkdXmDY2/Nf09o28fGnCpW1O6ZrLJHYVVkABHpKOa25kFdAidYGdH7e+h1BibCkhD
         g9piQVonXfajIRHA8XdT1sVo8dK0Bb53uST0eFxPzyBouFEoXTa4J14+Q9FfiKGsHGqf
         Lqi5bZbyqdGM3JdPm64007iIdl53xRj3P3vc9rK8/oL39zyaCRUY9yx4C/3tXxInUMM4
         iyEg==
X-Gm-Message-State: ACgBeo0aycT4BCQZu7E1VbXpnS+q9/hRTr3QVYTa8cV4IiQqQgsCRoXz
	lQIYozeDFulkWVg7ejTcnB4=
X-Google-Smtp-Source: AA6agR5ks2HiXQDRgyr3QL+lW7i7U1KOhZLMK43JH2+f1w/04SqGqm2qBCoVmfE/0zAm7bbjDV3Ojw==
X-Received: by 2002:a05:6a02:186:b0:431:25fb:f1fe with SMTP id bj6-20020a056a02018600b0043125fbf1femr8946563pgb.130.1662658285806;
        Thu, 08 Sep 2022 10:31:25 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b0016c57657977sm14862270plg.41.2022.09.08.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:31:25 -0700 (PDT)
Message-ID: <0913644cbda1bd56a556a3733fd2acbf9ab433f6.camel@gmail.com>
Subject: Re: Could not start RRM scan error - repeated
From: James Prestwood <prestwoj@gmail.com>
To: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>, "iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Thu, 08 Sep 2022 10:31:24 -0700
In-Reply-To: <AS8PR01MB7493D4E15D3465B3B0491B22F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
References: 
	<AS8PR01MB7493D4E15D3465B3B0491B22F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 2022-09-08 at 17:21 +0000, Johnson, Bryce wrote:
> Hi All,
> I am seeing this `Could not start RRM scan` and `Received error during
> CMD_TRIGGER_SCAN: Invalid argument (22)` error on iwd 1.29  every 15-30
> seconds.  This is on an buildroot built embedded linux device with a
> wf200 radio (2.13.2 driver).  I had previously had issues with
> connman+iwd and a lower version of iwd (1.25), but I removed connman
> for now and updated to iwd 1.29 (and ell 0.52).
> 
> 
> The error might be related to an occasional drop from the AP and not
> reconnecting as well.  I have only seen this on my home network (Tp-
> link archer A7 and archer C6), I have a few devices on different
> networks/APs and don't see this issue.  Next I'm going to disable
> roaming scanning to see if the issue goes away.
> 
> Here is the portion of the debug log that shows the error from iwd:
> 
> 2022-09-08 16:47:14.319877134  src/netdev.c:netdev_unicast_notify()
> Unicast notification Frame(59)
> 2022-09-08 16:47:14.320330902  src/wiphy.c:wiphy_radio_work_insert()
> Inserting work item 108
> 2022-09-08 16:47:14.320497579  src/wiphy.c:wiphy_radio_work_next()
> Starting work item 108
> 2022-09-08 16:47:14.320643359  Could not start RRM scan
> 2022-09-08 16:47:14.323058208  src/wiphy.c:wiphy_radio_work_done() Work
> item 108 done
> 2022-09-08 16:47:14.323230842  Received error during CMD_TRIGGER_SCAN:
> Invalid argument (22)

RRM scans happen when the AP requests a station (IWD) to scan, e.g. for
gathering spectrum data/usage of whats around you.

It shouldn't necissarily cause any problems, but we'd still like to
know why the scan itself is failing since IWD should be checking if the
requested scan is even possible on the hardware before trying to scan.

Could you run iwmon while this is happening and include the logs?

https://iwd.wiki.kernel.org/debugging

Thanks,
James

> 
> Thanks
> Bryce
> 
> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
> 
> This e-mail (including any attachments) is confidential and may be
> legally privileged. If you are not an intended recipient or an
> authorized representative of an intended recipient, you are prohibited
> from using, copying or distributing the information in this e-mail or
> its attachments. If you have received this e-mail in error, please
> notify the sender immediately by return e-mail and delete all copies of
> this message and any attachments. Thank you.
> 


