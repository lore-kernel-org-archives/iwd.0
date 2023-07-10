Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38944107B4
	for <iwd@lists.linux.dev>; Mon, 10 Jul 2023 17:13:38 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-26586e824e7so1528447a91.3
        for <iwd@lists.linux.dev>; Mon, 10 Jul 2023 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689009217; x=1691601217;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E78+6MfO+pXRx2G6k7gMjKs0gYYtxpEoZzF17HJQurM=;
        b=CqqEk06v1k+2o2c+ju+AARcSbnXTzl3zFJGwQNg6zLqN6gjTdB3/teFfk2/bAhhRdE
         UkrFSm+/S43FSzo4XYa9B9FO8rM1yIVi1R5U3rZpo+MvLZMoDHtd5sOJVAj46GklKHGm
         b8cRU6YTEk+/jFRhNGIgdvsaagaYrVsm/XQZiX2//+hNnMPy+DYa2cbUbUHN1GHeqHvB
         dYW21/b9zc/KNfyeXh/UOeGW4K8d2MBkQLt/tznnDi6uMT/RneNNv+9MissdCILd159x
         nMtPmwJVdVTWtLo5DE03WHz8g0ohCJjploqOoz34/7FyY6tNo5TTCoqZfZ1STcI6pukj
         ZUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009217; x=1691601217;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E78+6MfO+pXRx2G6k7gMjKs0gYYtxpEoZzF17HJQurM=;
        b=kFcUEDyLv1SVgYkBcoD7gjmH8XNx5r4v8HMAUWbvh9jShYDS7YCqCSHZnEtKu1V6uA
         j6XIhzdNxm5jfCCO8nni8huIH2h3ujAdK6pcjdJSYN/if6dZ/zhkoxfmwe6mrOSpQ8S9
         ErRGvOHvNAGy+IG/qA6dEB7RyvlqNwLnbtnaD5AwdZ907C2ky/g2MJPqcxbru7KxG2NW
         sYamgnCgaaHbo83zEYm4LY3r6jIdEdgfRyB/u5wX47D0TH+zsJ5JWC2ZBeQqfPYbOIHI
         iWAkwUFfHeuF4PSTkSOnagoxoWtFnDnEMYRW17UL2x2wES1W/Vgfe6dNFv4lNfNKnkDT
         ueIA==
X-Gm-Message-State: ABy/qLZ9R5Kq+fkjXh7ZZhWEjLCsd4x+BD2W3Y7zyXP8qhORnbUnAQhr
	rhSUzIEiSfjUUR8sFLFSkIM=
X-Google-Smtp-Source: APBJJlEQXlP5OX/a8o3ktBrP97/z6di4wv5yJo0EXHlnHioD1fViwYBKrE2dEYEHLv2rIYxl7aXoSw==
X-Received: by 2002:a17:90a:bd96:b0:262:f047:3569 with SMTP id z22-20020a17090abd9600b00262f0473569mr10292973pjr.8.1689009217375;
        Mon, 10 Jul 2023 10:13:37 -0700 (PDT)
Received: from [192.168.254.40] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id gw10-20020a17090b0a4a00b00262fc84b931sm6516363pjb.44.2023.07.10.10.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 10:13:36 -0700 (PDT)
Message-ID: <1a248b20-c31d-d948-48ab-4221c416a0bf@gmail.com>
Date: Mon, 10 Jul 2023 10:13:36 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 0/5] Initial refactor for hwsim frame processing
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230630191812.2884637-1-prestwoj@gmail.com>
 <12fbf71d-976d-fe2a-7326-547dab44b84a@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <12fbf71d-976d-fe2a-7326-547dab44b84a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 7/5/23 9:36 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 6/30/23 14:18, James Prestwood wrote:
>> I wanted to put this out there just as an idea before I get too
>> invested in extending it. The code itself needs cleanup (explained
>> later) but I wanted some feedback on the general idea.
> 
> No real objection, but if you're moving 1kloc of code around, make sure 
> that any moves are separated from overall refinements and other 
> changes.  For example, if you're exporting API functions or structures 
> for use in (newly created) modules, do that first.

Yep definitely.

> 
>>
>> Eventually I'd like to extend this to support remote communication
>> with multiple hwsim instances, e.g. via a multicast socket. As a
>> starting point the rules code fit nicely as a frame processing
>> module.
> 
> I assume you saw https://github.com/Raizo62/vwifi ?

I had not seen that one, but its pretty close to what I'm looking for. 
Still would need some specific modifications but its at least being 
maintained somewhat. Definitely worth looking into.

There is also a similar project, but its old and doesn't look 
particularly finished:

https://github.com/cmu-sei/welled

> 
>>
>> Cleanup:
>>   - Find solution for the IWD_MODULE_DEPENDS issue
> 
> Well, you need to put something into the section if you don't invoke 
> IWD_MODULE_DEPENDS at least once.
> 
>>   - Add getters for radio/interface info objects, possibly
>>     for hwsim_frame too rather than everything exposed in
>>     hwsim.h.
> 
> That would be preferable.
> 
>>   - The hwsim_frame cleanup in rules needs to be changed. Prior
>>     hwsim_frame_unref() would send tx_info but now this needs
>>     to be handled in rules.c. Currently we peek into the refcount
>>     and see if it will be destroyed on unref, and send tx_info
>>     then.
> 
> Hmm, not sure I follow yet?

Just minor details really, I need to just look at it closer once its in 
a more finished state.

> 
> Also, iwd/tools/* is for executables that get built from single files.  
> I guess we could relax that, but it may be better to have hwsim live in 
> its own directory, similar to ead & iwmon.

Ok that does make more sense.

> 
> Regards,
> -Denis
