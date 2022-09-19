Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204C7C
	for <iwd@lists.linux.dev>; Mon, 19 Sep 2022 15:42:42 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12803ac8113so62386888fac.8
        for <iwd@lists.linux.dev>; Mon, 19 Sep 2022 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f/pitk/zjrhk+SQ2KFMbUOAG6ijZALbJF3zUDPFPFec=;
        b=huUrkZiIN/LuyCgGmbkeWm+1zFFnpThOCpNSimIz7bhj1AF7RKSIzm8DhIXVNffHgF
         rYuCcJ+lFvlzxn5emm52TbZwWcFX0Ftvb95tWQCRHfS1mHcaEzfBDnZOavbiOdx5Gib9
         Pv/DKuwF+83LMVc4zs2dcmMGq4dg45A73Icfml/pw7bXknWOgzAjQSnOMqraneoNK8HX
         pZCUwW6Bd8Pfq4YZYzYG6akgSGNvSGCRcpexje8lVUrbuLJzFzWDVROneyRpYvoh/meu
         6x4IN3LpZB79w0LZlrIkH0fbBZZEmg3EyHOIi34rolx/pXstAar5qHsTSZ0sDNVKkHVm
         U6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f/pitk/zjrhk+SQ2KFMbUOAG6ijZALbJF3zUDPFPFec=;
        b=y0sSKBbByy34Klv3qgcFOlTiBxTKMPKuZLcsWqg1QFdUtQGN6ehU/UxtM6TIkomVNv
         46MQpT7KU0WvtIaYWkoJoxHDFZPObwuiTirF4/sYVUuvX6GmNqm/rHAhUqwLO8rOAwhj
         T86SHh9QV0DQw53aTVC8De023ymAvXSDWWJOsUuivqdAw2iQ89yDAXD0WcaclBn0d4ki
         8ZihMR9K23Z/ExO1YVLdhgJeAjhtadJ/bjk7jC3gonlfC04NP7CalqcRkCadClwK6OVQ
         VaoPWgAErypAig53ssCcI4d4MTS/VlupO9JKiXFlzIPTpIaaDUEtNjexSiYrQBXB6PSI
         l8ag==
X-Gm-Message-State: ACrzQf32/ie5Zg4NMb5INPd5xFMg7zrkoucRwoWI9JkWj6ZunnvxN4q5
	ERQ9uPylCgh33yscKeL7VEY=
X-Google-Smtp-Source: AMsMyM5Jc0KGC7Q13AC+5kEI1yxa+86ntCDiJNhYuGlkZfUHB8tnd7iM/Qzm8bIdruaDmOTI8ZZYSA==
X-Received: by 2002:a05:6870:58a6:b0:127:86d4:6707 with SMTP id be38-20020a05687058a600b0012786d46707mr9971979oab.88.1663602161919;
        Mon, 19 Sep 2022 08:42:41 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d7-20020a056830138700b00655c6b2655esm13330134otq.68.2022.09.19.08.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:42:41 -0700 (PDT)
Message-ID: <7b84828c-bf34-a254-f718-9bba111d3cc1@gmail.com>
Date: Mon, 19 Sep 2022 10:30:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Build issue in tests when LTO enabled
Content-Language: en-US
To: Sebastien Bacher <seb128@ubuntu.com>, iwd@lists.linux.dev
References: <8da6bf82-b708-c497-ea31-dbd1c7545f99@ubuntu.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <8da6bf82-b708-c497-ea31-dbd1c7545f99@ubuntu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastien,

On 9/19/22 05:37, Sebastien Bacher wrote:
> Hey there,
> 
> The issue is impacting Debian and Ubuntu, it has been reported on 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1015432 which includes the 
> build log; https://wiki.debian.org/ToolChain/LTO has details on how LTO is being 
> enabled in Debian, but basically 'Enabling LTO adds the flags -flto=auto 
> -ffat-lto-objects to CFLAGS, CXXFLAGS, OBJCFLAGS ... and the flag -flto=auto to 
> LDFLAGS'
> 

I think this came up before.  The issue is that we need to override certain 
implementation details to force certain behavior in unit tests.  The easiest way 
for us to accomplish this is to use -Wl,--wrap on a particular function.  For 
example, test-sae uses this to override l_ecc_supported_ike_groups() 
implementation to force the use of 256 bit ECC keys by default.  Ell unit tests 
do something similar for l_getrandom to force generating of known random numbers.

> the build is errors out on
> 

Problem is, -Wl,--wrap seems to not work with LTO:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88643

So I'm not sure what can be done about this.  One idea might be to not compile 
unit tests unless in maintainer-mode or disable unit tests at configure time. 
If you wish to run the unit tests (for build checks, sanity checks, etc) then 
you could compile the package without LTO first.

Regards,
-Denis
