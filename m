Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DD7E
	for <iwd@lists.linux.dev>; Tue,  6 Sep 2022 17:04:09 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 73so11216507pga.1
        for <iwd@lists.linux.dev>; Tue, 06 Sep 2022 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=uX97ShHE3sySCXvaJmcbF1+05KwU/kU1YEWU6Sxih0A=;
        b=PHs5gpd65QiOU/YEkLfRGp/kna2uu/mEhOHJB3RnoaUw8qdd2vX/ZBImUMSYPfEFT9
         MdCqosWvs6qiYwMMGSVC1Xs7eL8oBic0lDBfjZ94yjcPFpU5dWLgAz2Jg29Yc5ELDT8e
         vjVlwt+hO8RxQWdugX21PB/DIsUdygcBOtcdzB9Htz0YcwrnVKWo75wVjP88NcroQPOI
         pfqZ6y6Al0xDWxqIjKMhoN7T2SkFiYQAR09gKgrVpM19hSzW/NkJQqMhsAnESH7DS8of
         2U/Jj926hFE3x1exOxQaaYnSnaVV+4QpkOR31aWFK4gJnuC3LdGNENRk08X8lpsfW9E/
         BwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=uX97ShHE3sySCXvaJmcbF1+05KwU/kU1YEWU6Sxih0A=;
        b=vHyozCqUxv1ldPchq5lasm97IAAwO19d6Ycw1E2k+cP1Qs6pfz5Ny3FzcFuq2PB/o0
         +WhERo5/0vqKaQEL8NxTl6fQPzP/fY/4bGxzY7T/Au7/hKWCTP4HsSQXrAp77VqNcwiV
         qEaK0hFA+RVC3ZH9hYbhMXsUfiEWbftJDLKD7MX7O9ngpw/zyI/p8peoZIqihmAPUdiK
         ra1D2w/xPvt+oGwi1aQFabikLu5CQ0kNEZLVdy/289ffCgVU7XNL8JrTNjyMJOTbgM+L
         eX5i+6YFZ1LRHXG1eYUKit6HNbOXMzgvPqZD9eLswinr3Ui41mWhv11tkmHmJLgAa6z+
         kwYg==
X-Gm-Message-State: ACgBeo0HdjnUwI8O3sspDBLK6fRxS//ax9qlGdXxMJQngT7GIstPZypr
	3S7ntDgERs5sG6l7MjHr3lY=
X-Google-Smtp-Source: AA6agR65NCvVBG7tTYbKYlIvYq0dLWrcGIcUVCH+bPB/UqMzJkFnD6T6YkGoq+JJovwydeLmMe3g5w==
X-Received: by 2002:a05:6a00:1594:b0:537:b6ab:2dd5 with SMTP id u20-20020a056a00159400b00537b6ab2dd5mr55861277pfk.51.1662483849294;
        Tue, 06 Sep 2022 10:04:09 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id 184-20020a6215c1000000b0053e4baed9aesm1114587pfv.167.2022.09.06.10.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:04:09 -0700 (PDT)
Message-ID: <3652f00b82dfd58e5e6d62928f2021ec405434fc.camel@gmail.com>
Subject: Re: Cannot turn on AP mode without any error message
From: James Prestwood <prestwoj@gmail.com>
To: Chang Liu <goduck777@gmail.com>, iwd@lists.linux.dev
Date: Tue, 06 Sep 2022 10:04:08 -0700
In-Reply-To: <d007b616-5957-8010-bb01-bae8a5398add@gmail.com>
References: <2031ff9c-0fff-18f7-2ad7-860e2b51ee22@gmail.com>
	 <f66462932dacecb2231bf356770165309c49beab.camel@gmail.com>
	 <7fc91799-e030-fe90-44e9-c6490fbb6bb8@gmail.com>
	 <e5c70eecaa96e951176b6f99912822cb2ef5b3a9.camel@gmail.com>
	 <d007b616-5957-8010-bb01-bae8a5398add@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2022-09-02 at 11:50 +0900, Chang Liu wrote:
> 
> Hi,
> 
> On 9/1/22 1:04 AM, James Prestwood wrote:
> 
> > Then 3 seconds later the kernel sends STOP_AP...
> 
> Sorry for confusing you. The STOP_AP signal is caused by I pressing
> the 
> Ctrl-C to stop the iwd process. If I don't stop it, then it will just
> do 
> Start AP and then nothing.

No worries, thanks for testing with wpa_supplicant as well.

<snip>
> 

> So I think wpa_supplicant did something more than iwd after start AP.

(and before), but yes, it seems something with Ath10k or this adapter
specifically expects userspace to do more than what we are. We tested
on ath9k and had no issues.

I have a feeling the driver/firmware is trying to handle probe
responses internally, and maybe even more frames since there is no
frame registrations in the wpa_supplicant case. IWD expects to handle
these in userspace.

Sorry, we don't have a fix just yet... we need to get one of these
ath10k cards to figure it out what its expecting IWD to do. Most of
these extra commands/attributes are poorly documented so its unclear
exactly what they do and whether or not they are required.

> 
> > Thanks,
> > James
> > 
> 
> Thanks,
> 
> Chang


