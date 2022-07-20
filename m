Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE3746F
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 20:08:36 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id y141so17430835pfb.7
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=10CGt9YzG4RHWlqm0ng2h6l42AyQ/Gm+tAhAq8O2bbc=;
        b=n1xUOiTsBj19DvpBHeKpvCuReDkd8TFo33rPFH0ahpQ0mwx0OHuYhZziRLqdY8CG9a
         rIFYb35QCKcI6nBKuPWKBMYBa0rqfGqyl5jWegrZ+5c6UIXjDLFMwAhkfs9WomGUms08
         36nxqSTl9a2xT+1lJl/GzsleORmQG7XjMpxkF3TmqQZY3flvLiZsAEIcLA8aM4iEaISK
         LTL1LXFSbwYkWzAaX7xT+rI7CIpnqrHjs6QW8dWDOroHej9eE6Jdtw3pyItAzQyZUKS/
         KCyNGt7WUwUPcqbTGNYwrrEdJNsjW5zossCLOsNPV4r2K1tDZAAVZ+sr79Aw4CS8cDpS
         Fexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=10CGt9YzG4RHWlqm0ng2h6l42AyQ/Gm+tAhAq8O2bbc=;
        b=As4zD9jATVHSaT0JORO9gpu+yUUJ1QlnoS7v+h/9Pb2KFVWlycQlQ1LaLifVU6elAF
         6SRIQvcW6dW0ipNEODoCUWFwhEQq/xxFNEJArGpsiiJN9XnZUwxjuYRmhK88on3BsAcq
         /9hdtdIvniCkCLsXuyMHc6L5Fqc316tfVWBjN37PyM7Bid4lYbz1V9UsR069JQEJdXd0
         m7gVVQULsHsfSeBDTpLJoxfTq2hWb1fyi/ZzNGMBbQV7+SNodOVZ5Gnyrj6qevIM4FEa
         bkklPIBRSWSsZZJFYSk6UacYdFWOhPmQ8aGAdzHsF3HY6tbijp+4z91oG/jHvKUsJpBk
         ZhDA==
X-Gm-Message-State: AJIora/MoEUbSNjSzqbfXp2NzaE8g77B0tcGnHdzvGBwltixITzr4HIq
	RO6FG+3neQVVSCMZ3HMSVT/Dcvog/cw=
X-Google-Smtp-Source: AGRyM1s9DyRqts7S6E5go6H9AQGsCeSZhLwL/iR7NLjt7zwmR83iCNDxuCZqQRWDUcNqA0hxNCrhMw==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr41123422pfu.6.1658347716121;
        Wed, 20 Jul 2022 13:08:36 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902bf4100b0016a058b7547sm14199064pls.294.2022.07.20.13.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 13:08:35 -0700 (PDT)
Message-ID: <8a9125c17d9517473d16ed96fc044217cb372023.camel@gmail.com>
Subject: Re: iwd fails to connect when passphrase > 40 characters on 5Ghz;
 times out on 2.4Ghz
From: James Prestwood <prestwoj@gmail.com>
To: James Tavares <jtavares@kvh.com>, Denis Kenzior <denkenz@gmail.com>, 
	"iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Wed, 20 Jul 2022 13:08:35 -0700
In-Reply-To: <caccaddd-4d7e-11e3-5aca-3d7b6c8e40da@kvh.com>
References: <E34D86E6-F357-4233-A698-C0EAC029F431@kvh.com>
	 <e74694b1-f62c-f430-6c2f-32d275c61763@gmail.com>
	 <caccaddd-4d7e-11e3-5aca-3d7b6c8e40da@kvh.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi James,

You might also give wpa_supplicant a try and see if it works. Either
way we'll still need to figure out the issue (since you're Mac handles
it fine) but its at least another bread crumb.

Also, running iwmon during this connection attempt is gonna provide a
lot more info on why the AP rejects msg 2/4. Doing this for separately
for wpa_supplicant and IWD would be great.

https://iwd.wiki.kernel.org/debugging

Thanks,
James




