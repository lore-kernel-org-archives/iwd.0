Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1E24F2B
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:47:59 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id l6so17390193pjj.0
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll1yUNBb9EB531HNpmI/xOVnbLDcDupNyB86ggqAg4A=;
        b=l01mv3eFR+3Lm5ox/dK6REfS0pHFzss6Kp3TDHqikC+NrEXu0H6sqmOU5fWoOFS4Eg
         sfmOwJ3wOnemNFIbXzfNF//OM/9ObhXkEASIXC36jCNJ+TLKIexrQ+LtQjOVfVMuzkDf
         cGjukK8CNRe/uudNqB8HfSgxTIDP31jcUmmKArgn+wqXFfzLspgOHpV9WLvWRP8EFz7g
         1Po2K7V6RP8TXaFv4X7jhB5tX/2P35oOEchM+JiKke69p3wvabyTAanl01FUAHFd/RCF
         hNQy6aGaEVBRlu2Yh5mTzwVSpEDOxQlmLb4iMhs/a/mrTXaxsUAEazXWF4mHxOZuJKxg
         20Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll1yUNBb9EB531HNpmI/xOVnbLDcDupNyB86ggqAg4A=;
        b=tSL1RpCNjWwi6alV2brI0SFPw+nP6U/w1goQYGDF9p7A/Y0jedRtxuDpRZ8G9ShlwD
         AJGlnxfWHasIfa0p0gVzIwRJ2vZZInObETMjmO+T6Mt5wOLwswwfD4mzH497DShi5y2p
         MxE0Pi5PMJG93dDqkBvkmHinEW+X2CTT2pyryLHb8S5rzNsvuEcAB8cmMkiXFMgII2Jt
         e5QO+GiSjyOBAX/tS0/1BR9wyrjdD3/y7AANJJRD7ebwL0oVIvpLJGxZ1ZK8lh/OryHH
         vZUn+m3MSNp4TK0cTHxsJh4FpQpR+cygPNtbbuNcNzEZqzkU8dP9b/Q0OPIuqLIJRXes
         nDpA==
X-Gm-Message-State: ACrzQf1kOjhLA9Eq7IyltzKwwrmX05zXbrDnU7bPBCrHFtxqpnMfGskw
	re1LYOdhHtei84VuCA5aTo9nBfEUEyE=
X-Google-Smtp-Source: AMsMyM6kwZkYXP5mcfYj2UMcNrbfCrnSZ+1IROr3fj+dS+rKr2iTGSwlaR+pk1AHwM+9tgb2cQmE/Q==
X-Received: by 2002:a17:90b:524f:b0:212:c22f:fbd1 with SMTP id sh15-20020a17090b524f00b00212c22ffbd1mr28275366pjb.155.1667422078606;
        Wed, 02 Nov 2022 13:47:58 -0700 (PDT)
Received: from [192.168.254.69] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b00176d347e9a7sm8820971plg.233.2022.11.02.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:47:58 -0700 (PDT)
Message-ID: <c1a5ac7f3d1efb63c66218c147d6188e3e8ebc51.camel@gmail.com>
Subject: Re: MulticastDNS for all connections
From: James Prestwood <prestwoj@gmail.com>
To: Andrea Pappacoda <andrea@pappacoda.it>
Cc: iwd@lists.linux.dev
Date: Wed, 02 Nov 2022 13:47:57 -0700
In-Reply-To: <CZLQKR.DUWHOW09XS8D@pappacoda.it>
References: <A4TIKR.5DC9OCNE90W6@pappacoda.it>
	 <66b9f15578d9f7112e532a7174268b02b629360f.camel@gmail.com>
	 <CZLQKR.DUWHOW09XS8D@pappacoda.it>
Content-Type: multipart/mixed; boundary="=-EObAWBRIL4qwhCbCLv0v"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-EObAWBRIL4qwhCbCLv0v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-11-02 at 21:23 +0100, Andrea Pappacoda wrote:
> Hi James, thanks for your reply :)
> 
> Il giorno mar 1 nov 2022 alle 13:54:36 -07:00:00, James Prestwood 
> <prestwoj@gmail.com> ha scritto:
> > Currently the MulticastDNS option is only per-network, but systemd-
> > resolved has a global setting itself according to the docs [1].
> > 
> > But I actually wonder if event setting MulticastDNS in IWD is doing
> > anything:
> > 
> > "Multicast DNS will be enabled on a link only if the per-link and
> > the
> > global setting is on."
> > 
> > This would imply you need to set /etc/systemd/resolved.conf with
> > MulticastDNS=true to even use mDNS at all? Or maybe you have
> > already
> > done this? And I see the problem, per-link settings are only in
> > systemd-networkd, which you don't use...
> 
> Yes, MulticastDNS needs to be enabled globally in resolved.conf (it
> is 
> enabled by default) and also be enabled by whoever is managing the 
> network interface.
> 
> Enabling mDNS in specific networks by adding MulticastDNS=true in 
> /var/lib/iwd/network-name works as expected.
> 
> > Like I said, I don't know much about mDNS but would a global option
> > 'break' networks which don't support mDNS? Are you frequently
> > connecting to many networks and needed to add this option to the
> > profile each time?
> 
> I used to have mDNS globally enabled in NetworkManager, and it never 
> created issues. As far as I understand, enabling mDNS simply allows
> you 
> do to Multicast DNS queries on that network; it shouldn't interfere 
> with non-multicast queries. I use mDNS every once in a while (on
> three 
> different networks since last week), so I'd like to simply enable the
> global setting and forget about it.
> 
> > The fact that this depends on setting systemd-resolved's global
> > option
> > and the per-link option I would say this really should stay in 
> > systemd-
> > * itself. The IWD setting is kinda useless without the global
> > option
> > anyways. Plus systemd-networkd is much more flexible, you can match
> > based on all kinds of things where IWD is very rigid (global or
> > per-
> > network).
> 
> iwd has an option that enables it to replace other network managers
> for 
> simple use cases, EnableNetworkConfiguration=true, so it seems 
> reasonable for somebody to not have any other connection manager 
> installed, and for those use cases I'd say that iwd's coarseness is 
> fine. I've applied a quick and dirty patch on top of version 1.30,
> and 
> it seems to work without issues; mdns_global probably leaks, but this
> can't be applied on master anyway and I was just trying to figure out
> how easy it would be to add this feature.
> 

I've attached a patch if you want to try it out. I quickly tested only
that "resolvectl status" showed +mDNS or -mDNS depending on what it was
set to. In actuality this is probably enough since all we do is set the
value to systemd and let it handle it.


--=-EObAWBRIL4qwhCbCLv0v
Content-Disposition: attachment; filename="0001-netconfig-add-global-MulticastDNS-option.patch"
Content-Type: text/x-patch; name="0001-netconfig-add-global-MulticastDNS-option.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA2N2NhODg5YTMwNzVmNTliMDNmODU3ZTJhZTU0OGEyMWU3NzM4MzQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBQcmVzdHdvb2QgPHByZXN0d29qQGdtYWlsLmNvbT4K
RGF0ZTogV2VkLCAyIE5vdiAyMDIyIDEzOjM1OjUzIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gbmV0
Y29uZmlnOiBhZGQgZ2xvYmFsIE11bHRpY2FzdEROUyBvcHRpb24KCkFkZHMgdGhlIE11bHRpY2Fz
dEROUyBvcHRpb24gZ2xvYmFsbHkgdG8gbWFpbi5jb25mLiBJZiBzZXQgYWxsCm5ldHdvcmsgY29u
bmVjdGlvbnMgKHdoZW4gbmV0Y29uZmlnIGlzIGVuYWJsZWQpIHdpbGwgc2V0IG1ETlMKc3VwcG9y
dCBpbnRvIHRoZSByZXNvbHZlci4gTm90ZSB0aGF0IGFuIGluZGl2aWR1YWwgbmV0d29yayBwcm9m
aWxlCmNhbiBzdGlsbCBvdmVycmlkZSB0aGUgZ2xvYmFsIHZhbHVlIGlmIGl0IHNldHMgTXVsdGlj
YXN0RE5TLgotLS0KIHNyYy9uZXRjb25maWcuYyB8IDIyICsrKysrKysrKysrKysrKy0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3NyYy9uZXRjb25maWcuYyBiL3NyYy9uZXRjb25maWcuYwppbmRleCBlNjc3OWQ3Yy4u
OGI3OThlMGIgMTAwNjQ0Ci0tLSBhL3NyYy9uZXRjb25maWcuYworKysgYi9zcmMvbmV0Y29uZmln
LmMKQEAgLTU2LDYgKzU2LDcgQEAKICAqLwogc3RhdGljIHVpbnQzMl90IFJPVVRFX1BSSU9SSVRZ
X09GRlNFVDsKIHN0YXRpYyBib29sIGlwdjZfZW5hYmxlZDsKK3N0YXRpYyBjaGFyICptZG5zX2ds
b2JhbDsKIAogc3RhdGljIHZvaWQgZG9fZGVidWcoY29uc3QgY2hhciAqc3RyLCB2b2lkICp1c2Vy
X2RhdGEpCiB7CkBAIC0zOTYsMTMgKzM5NywxNiBAQCBzZW5kX2hvc3RuYW1lOgogCX0KIAogbWRu
czoKLQlpZiAobF9zZXR0aW5nc19oYXNfa2V5KGFjdGl2ZV9zZXR0aW5ncywgIk5ldHdvcmsiLCAi
TXVsdGljYXN0RE5TIikgJiYKLQkJCSEobWRucyA9IGxfc2V0dGluZ3NfZ2V0X3N0cmluZyhhY3Rp
dmVfc2V0dGluZ3MsCi0JCQkJCQkJIk5ldHdvcmsiLAotCQkJCQkJCSJNdWx0aWNhc3RETlMiKSkp
IHsKLQkJbF9lcnJvcigibmV0Y29uZmlnOiBDYW4ndCBsb2FkIE5ldHdvcmsuTXVsdGljYXN0RE5T
Iik7Ci0JCXN1Y2Nlc3MgPSBmYWxzZTsKLQl9CisJLyogSWYgdGhlIG5ldHdvcmtzIGhhcyB0aGlz
IHNldCB0YWtlIHRoYXQgb3ZlciB0aGUgZ2xvYmFsICovCisJaWYgKGxfc2V0dGluZ3NfaGFzX2tl
eShhY3RpdmVfc2V0dGluZ3MsICJOZXR3b3JrIiwgIk11bHRpY2FzdEROUyIpKSB7CisJCW1kbnMg
PSBsX3NldHRpbmdzX2dldF9zdHJpbmcoYWN0aXZlX3NldHRpbmdzLCAiTmV0d29yayIsCisJCQkJ
CQkJIk11bHRpY2FzdEROUyIpOworCQlpZiAoIW1kbnMpIHsKKwkJCWxfZXJyb3IoIm5ldGNvbmZp
ZzogQ2FuJ3QgbG9hZCBOZXR3b3JrLk11bHRpY2FzdEROUyIpOworCQkJc3VjY2VzcyA9IGZhbHNl
OworCQl9CisJfSBlbHNlIGlmIChtZG5zX2dsb2JhbCkKKwkJbWRucyA9IGxfc3RyZHVwKG1kbnNf
Z2xvYmFsKTsKIAogCWlmIChtZG5zICYmICFMX0lOX1NUUlNFVChtZG5zLCAidHJ1ZSIsICJmYWxz
ZSIsICJyZXNvbHZlIikpIHsKIAkJbF9lcnJvcigibmV0Y29uZmlnOiBCYWQgTmV0d29yay5NdWx0
aWNhc3RETlMgdmFsdWUgJyVzJyIsIG1kbnMpOwpAQCAtNzUzLDExICs3NTcsMTUgQEAgc3RhdGlj
IGludCBuZXRjb25maWdfaW5pdCh2b2lkKQogCQkJCQkmaXB2Nl9lbmFibGVkKSkKIAkJaXB2Nl9l
bmFibGVkID0gZmFsc2U7CiAKKwltZG5zX2dsb2JhbCA9IGxfc2V0dGluZ3NfZ2V0X3N0cmluZyhp
d2RfZ2V0X2NvbmZpZygpLCAiTmV0d29yayIsCisJCQkJCQkiTXVsdGljYXN0RE5TIik7CisKIAly
ZXR1cm4gMDsKIH0KIAogc3RhdGljIHZvaWQgbmV0Y29uZmlnX2V4aXQodm9pZCkKIHsKKwlsX2Zy
ZWUobWRuc19nbG9iYWwpOwogfQogCiBJV0RfTU9EVUxFKG5ldGNvbmZpZywgbmV0Y29uZmlnX2lu
aXQsIG5ldGNvbmZpZ19leGl0KQotLSAKMi4zNC4zCgo=


--=-EObAWBRIL4qwhCbCLv0v--

