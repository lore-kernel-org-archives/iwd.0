Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCE53B9
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 19:06:47 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id q18-20020a056830441200b006704633f258so7932174otv.0
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XX5DNEWWIphEX1MK8B8VL+RwpFYa9mB7Bn7QUStdww=;
        b=Fs0DGUGqN4QB/uiTwizBO0MnmVHMrbNxXnXW98eCRbCEM3yS+o6D7QZ6UXELX4Tqu6
         Pt800+EjPZtv1sBibApkYqkZ8PquxyoJVsbIotoymVOwvUhEHFLTmprS3MwB1t7gbWdV
         x5AALo3m23sfO5hpJXmG5S/k9C/Rgg72vVZ0j7Cj+cOnXJTRb902xRH8Jls28TemXHaa
         vste8lAAIgggzOn8ut50/5+Plb9HoJS7uwC2dpJ7qVQUfHQSEswkVDQBSqXs7pt0pJov
         3L7k1bYuu5CgLBce0AOYXONWUtAsRxvFeMGcTrjsSda1yovLUfYZT7pw+4JSORHZKk42
         4brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XX5DNEWWIphEX1MK8B8VL+RwpFYa9mB7Bn7QUStdww=;
        b=tYxnjWU3IMA3FnxhVMuEp0V/8t6omUxIlRxPDtcEQYJTBGzd5iM51JCM7TPCO5iSUJ
         yxsQh68FPCqKSShiISUXqjqo1oJs4doUg+C7/FyT9HGkT7ko15BytYp+TLHhoy+2tMlw
         vawOzPF1Ip8oittMNzsGtSWGVVUeMWl69n3Ai+BjSmfE/+egp0BVgtbRGHOhnM7hAJzI
         a8ijhIYIsTT2/YjdonVeNnyxH+KFCNv6QuRv0onZ+ISdoyhj7qD+Vfxt5i/XazPssHn1
         w9K7p8RqS6ii5zZzQR+WrQHNGlz+pWJnO9fkH9adqyqpa7xXzW0Wfl3Eo5g1d+lQHKXJ
         Epnw==
X-Gm-Message-State: ANoB5pkLjeM++3dQbRdmXTpkkFRo45Z/Ifmr5Ei0cA8v3AgZ/5M49OiS
	vx9D+Xop51r0OSJNH6+lrfg=
X-Google-Smtp-Source: AA0mqf6GxCI9XeVIhdMDN69P50C1nx/lOW26sG1uPC0peSGdjmfSR0/PR7LItsp7ruhRwR01v+OdLA==
X-Received: by 2002:a05:6830:1513:b0:670:8676:76ee with SMTP id k19-20020a056830151300b00670867676eemr5355276otp.36.1670872006638;
        Mon, 12 Dec 2022 11:06:46 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g3-20020a9d6203000000b006708a6274afsm273615otj.25.2022.12.12.11.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 11:06:45 -0800 (PST)
Message-ID: <0df6f28d-4a77-dea2-dbf6-c83c6a25b8ae@gmail.com>
Date: Mon, 12 Dec 2022 13:01:12 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: iwd release 1.30 onwards cannot find available networks
Content-Language: en-US
To: Bruno Dantas <dantas@airpost.net>, James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
References: <b7ff5956-f571-d9d8-1f7b-f3025e2055ae@airpost.net>
 <b4ad714bbd162b1f7bc3302c9585adf8811ac929.camel@gmail.com>
 <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <126d2f2b-07ef-fd22-7656-dcd21f3cece0@airpost.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bruno,

>> Just to be clear, you are making sure IWD scans prior to calling 'get-
>> networks' right? i.e. station wlan0 scan?
> 
> Yes, but the scan just hangs. I wait a full minute before interrupting the scan with Ctrl+c.
> 

This doesn't make much sense.  get-networks doesn't scan, it just returns the 
cached networks that iwd knows about.  If you want to scan, use 'station wlan0 
scan'.

And can you elaborate what 'hangs' mean?  If there are no networks, then you 
should see a "No networks available" print or something similar.

>> But assuming IWD is scanning (or trying) we need to see some debug logs
>> for IWD, and best if you could also get an iwmon trace when IWD starts
>> up and issues scans, and when you call get-networks. More info how to
>> do that here:
> 
> No problem. When using latest iwd 2.0, then letting it scan for a minute before interrupting, then running get-networks, here is the iwmon trace:
> https://pastebin.com/h7gHrS2w
> 
> And "iwd -d" output:
> https://pastebin.com/2y5hHfWa
> 

According to iwmon, there is nothing coming up in the scan results.

Can you run a few scans manually using 'station foo scan'?

Regards,
-Denis
