Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536097C
	for <iwd@lists.linux.dev>; Wed, 16 Nov 2022 02:33:12 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id q186so17003683oia.9
        for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 18:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUG59bzA76oKNqMtkeCP7vbeNa99rSLs0V86Ru4ZPB0=;
        b=EtjwdYWD8VOshZILF3XyBmTMHUM/BJ9VDk6zKVer7GLMktBQGXAdHXwTXhvgWo+kp3
         jkEtp/xljQp/+fbsk8tI8enV5zv01Ei6RnsaJx3sSJiJmzm12w97hwRvjDFHuYYheSXw
         XxHESMVMlaQgYt4H8keZ5clooBYebk0P5jKiS7upRLKFmdTjjx9NoRBVvQhqDWG2FS55
         ePfnTv718cLQt+h760jKSv6oxDh0hjRuGQ7fwIzbMIeDxFXydreDSO1NbuzHPicbuP69
         HtjE0cVWriQw40+XhkyonvCc+RiaX5xh4LYmAcL6hO3YZlLnsYxyObWZ4K9Gi+gjEeBe
         Cb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUG59bzA76oKNqMtkeCP7vbeNa99rSLs0V86Ru4ZPB0=;
        b=JZL379us7gYpkLoFZk+QkluDIsVAhqwTX6I3Hk2kAphsijiyjZNbQo/cS2/9Lek3Z4
         Mo9LWYwSveTf/vXw8cgv+4iErj6jFYrdTJfZVSOyQSoq2w/lHMoqXz7LptlBTvsumcTd
         Ocl1erXd5CjyKRzgNUw8dMKH1G2HNyLZiVs+h9XT8q9xIZlz6JmMWFnFL9/Ck6s8DLor
         MSL2/7cKjBJ06cSqLcWroK5L4uxaEk/8JKLuOY3PRTL+Qf3Yd9EABPHCSiVXsk/KpjCX
         K+5zIBmqjenjTNNXNmK8Rrc5Yf2bIuRPhacPHCKeCSUM4byYr0ZWpmpTHV5v7BbcXRzs
         9Wkw==
X-Gm-Message-State: ANoB5pmpTugZ2dbFxb/5WGVoTwLVLjQc1hr15PwBfdk0GaitFpShmXa5
	74DoB6Cdwkoi2BC60epi6Xs=
X-Google-Smtp-Source: AA0mqf5cFLUBQJrjcjM57w0hiMCs9uijKPxXlfh3zUIa8Z9bVEIdhUDyBvu4cDQgeyOgmm7OeUK9LA==
X-Received: by 2002:a05:6808:a07:b0:354:d122:1be4 with SMTP id n7-20020a0568080a0700b00354d1221be4mr617069oij.94.1668565991408;
        Tue, 15 Nov 2022 18:33:11 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id be28-20020a056870589c00b0013b09a56d59sm7334522oab.27.2022.11.15.18.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 18:33:10 -0800 (PST)
Message-ID: <758cebe9-e3a1-e6da-451a-ffd1ee9ab6e0@gmail.com>
Date: Tue, 15 Nov 2022 20:33:09 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] storage: Maintain the tls session cache object
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: iwd@lists.linux.dev
References: <20221112011929.785388-1-andrew.zaborowski@intel.com>
 <a9af6470-6363-5362-f81d-0d612ab851da@gmail.com>
 <CAOq732L4CaibiV=7rtWLEW0Wk9wGycLnwKB8=39TnmNwwby4KQ@mail.gmail.com>
 <c6bea4a7-4f4f-38f1-82ca-8db7d36a13f3@gmail.com>
 <CAOq732JNqRgfh1m8GyqviCNU=A9GtxK3NM8ecVDT6Nk+yHDWCw@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOq732JNqRgfh1m8GyqviCNU=A9GtxK3NM8ecVDT6Nk+yHDWCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

>> Actually, any removal triggered by the user won't work either since this path
>> doesn't use storage_network_remove().
> 
> known_network_forget does call ops->remove which translates to
> storage_network_remove for non-Hotspot networks.
> 

Yes, but that is not what actually removes the network.  That just generates a 
fancy 'rm /var/lib/foo.8021x' call.  The actual magic is in 
known_networks_remove() which is called by both hotspot inotify logic as well as 
known networks inotify logic.

Regards,
-Denis
