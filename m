Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36607F
	for <iwd@lists.linux.dev>; Mon,  1 Aug 2022 18:40:15 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-10e615a36b0so13163652fac.1
        for <iwd@lists.linux.dev>; Mon, 01 Aug 2022 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Gs494ayUVnanwqpkM4arENRtdZP64ZkTtslr8zm5dV4=;
        b=PVy91BN9CAnuQjKXlZ8JrLTan3RRqBlAcjZtONPjzTx9i24GXTBGaE8GCFS8ixjdze
         Tf3jBrZJQFk06CY8sbYD38OHr0RfFJVDT/sWHnIrPjWpmmzx8vsyPH8Pg+NrZ1Oj6cM/
         k3x8TFGM1pO0b6qoYs3VU3ahGx6doMlNu8i4U80Pg/XqwjtzDRGRD/43d0pTIWG2OGkI
         0frwvsoQiUR2Nl2JX90vjNTZBr+NRPYuPhqKhAJWqFXuR9FWeDbbWa+xyPG5MsCjC5Nw
         0vXekr3KVObisA9aP8lAE12k8Ye373lJaRjox6sMN70T9aTYOs8nDQ517JKLdkBR97HT
         yFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gs494ayUVnanwqpkM4arENRtdZP64ZkTtslr8zm5dV4=;
        b=lYwKWmSvR5XDfqevTKbFBGaJ81iAcMODA9YgYiSx2L8lVrQd1wOub8ZJogiZUeTi1G
         WdCu2mOrhgiLxVkyY7K99isVS8RJZ1esOg5QEM+Pb4Izuaij86y/9F6jHcBS2LGmmNhB
         7+uym+m4F+DoPhZzjSWWNugBPyouq8hFzqTYr26UV8SKI9t3aRWip51f3SF7FkO03Csr
         nwDtDgrOEv6edaFGb/JqAUV5eZ0Hf9q7twesovvvCGAkr7xwZs/MXTnxXnKfPywZ5f3l
         Y+VyouoVFl5JrRBzVgjfcmgSUbt64lszELl9WcYiRR0ZRSu8QO7WspO7lD9ptP/drYwr
         Vy8w==
X-Gm-Message-State: ACgBeo2G9VOkrgk1/a7r/jxC3EEem+acEpA5N4bwg/MPTuHSiEqb9WFD
	MZPPTVR5eZ/OMVTHPLOs5KU=
X-Google-Smtp-Source: AA6agR6RUnsXCw0QgGLWYtRmcLgidIkCuZHG69o0AMFQ2IhUB362NjQB1bUmm4yNfOAwGBDflHJebA==
X-Received: by 2002:a05:6870:808b:b0:10e:cb5e:b268 with SMTP id q11-20020a056870808b00b0010ecb5eb268mr4052362oab.162.1659379214854;
        Mon, 01 Aug 2022 11:40:14 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l44-20020a9d1b2f000000b0061d1f5582dfsm2947438otl.0.2022.08.01.11.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 11:40:14 -0700 (PDT)
Message-ID: <837ca848-73dc-3811-2845-8d9be235afa6@gmail.com>
Date: Mon, 1 Aug 2022 13:30:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] netdev: Add logging for CQM messages
Content-Language: en-US
To: Michael Johnson <mjohnson459@gmail.com>
Cc: iwd@lists.linux.dev
References: <20220801100631.41605-1-mjohnson459@gmail.com>
 <6bc199e2-2f40-b192-9de6-30fceb2510ea@gmail.com>
 <CACsRnHULBH=jmCiG4=kczJALPsy7Whx+TmDf-JhQryyc5GwBow@mail.gmail.com>
 <c012837a-9d79-1909-dd2f-3fcd98828d52@gmail.com>
 <CACsRnHW4N1aBkcJyeAppgMj1bqV8t3V_BwYrjy+MB=S0uepaWg@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACsRnHW4N1aBkcJyeAppgMj1bqV8t3V_BwYrjy+MB=S0uepaWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 8/1/22 13:09, Michael Johnson wrote:
> Hi Denis,
> 
> On Mon, 1 Aug 2022 at 18:24, Denis Kenzior <denkenz@gmail.com> wrote:
>> I wonder if we should report this over D-Bus instead?  I mean you can always
>> setup your own SignalLevelAgent, or we could even add more reporting via
>> StationDiagnostic interface?
> 
> I actually do record the signal level separately but it's stored in an
> annoying binary format so access is more painful :(. This was just to
> make things easier and reduce the jump from wpa_supplicant to iwd for
> anyone on plain ubuntu etc. I can understand why you don't want the
> spam though.

I don't mind the spam in debug mode, that's what it is for.  But not sure they 
really belong at info/warn levels.  I think we can consider putting in roaming 
related messages at the info level since that type of information might be 
generally useful.

> 
>> Right, but I think it sets a single CQM threshold, not multiple like we (might)
>> do.  Also, wpa_s is very spammy since it is really (only) meant for testing wifi
>> implementations in a lab ;)
> 
> haha fair. Of course, it's still the default on most linux systems ;).
> 

And we're working to change that.

> 
> What would you like to do with the patch? I'm happy to drop it if its
> too spammy or we can lower the level to debug? Or make it only print
> when the threshold changes.

I don't mind these at debug level, if you want to start with that.

> Are you happy with the packet loss and beacon loss events or are they
> too much as well?

As I mentioned before, kernel will generally disconnect us as soon as the beacon 
loss event happens (depends on the STA capability if I recall correctly).  Not 
sure how really useful this is, but since beacon loss goes via dmesg at 'info' 
level, I think it would be fine for iwd to do so as well.

The packet loss one I'm not sure.  Certaintly not 'warn'.  I think I'd start 
with 'debug' since this event isn't being reacted to (yet).

Regards,
-Denis
