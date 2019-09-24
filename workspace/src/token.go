package main

import (
	"encoding/base64"
	"github.com/hashicorp/errwrap"
	"fmt"
 )

// XORBytes takes two byte slices and XORs them together, returning the final
// byte slice. It is an error to pass in two byte slices that do not have the
// same length.
func XORBytes(a, b []byte) ([]byte, error) {
	if len(a) != len(b) {
		return nil, fmt.Errorf("length of byte slices is not equivalent: %d != %d", len(a), len(b))
	}

	buf := make([]byte, len(a))

	for i, _ := range a {
		buf[i] = a[i] ^ b[i]
	}

	return buf, nil
}

// XORBase64 takes two base64-encoded strings and XORs the decoded byte slices
// together, returning the final byte slice. It is an error to pass in two
// strings that do not have the same length to their base64-decoded byte slice.
func XORBase64(a, b string) ([]byte, error) {
	aBytes, err := base64.StdEncoding.DecodeString(a)
	if err != nil {
		return nil, errwrap.Wrapf("error decoding first base64 value: {{err}}", err)
	}
	if aBytes == nil || len(aBytes) == 0 {
		return nil, fmt.Errorf("decoded first base64 value is nil or empty")
	}

	bBytes, err := base64.StdEncoding.DecodeString(b)
	if err != nil {
		return nil, errwrap.Wrapf("error decoding second base64 value: {{err}}", err)
	}
	if bBytes == nil || len(bBytes) == 0 {
		return nil, fmt.Errorf("decoded second base64 value is nil or empty")
	}

	return XORBytes(aBytes, bBytes)
}


const (
	
	tokenB64    = "djw4BR1iaDUFIBxaAwpiCC1YGhQHHDMf" 
	xorB64      = "EYHAkPQYvvz93e8iI3pg1maQ"
)


func main() {
    

 tokenBytes, err := base64.RawStdEncoding.DecodeString(tokenB64)
		if err != nil {
			fmt.Println("Error decoding base64'd token")
			
		}

 tokenBytes, err  = XORBytes(tokenBytes, []byte(xorB64))
		if err != nil {
			fmt.Println("Error xoring token")
			
		}

                        
               fmt.Println("tokenBytes:" , tokenBytes)


tokenEncoded  := base64.StdEncoding.EncodeToString(tokenBytes)
                if err != nil {
                        fmt.Println("Error encoding base64'd token")

               } 

                fmt.Println("tokenEncoded:" , tokenEncoded)        

tokenDecoded, err   := base64.RawStdEncoding.DecodeString(tokenEncoded)
                if err != nil {
                        fmt.Println("Error decoding base64'd token")

               }                

               fmt.Println("tokenDecoded:" , string(tokenDecoded))

// if tokenDecoded  := base64.RawStdEncoding.DecodeString(tokenEncoded); tokenDecoded != expectedB64 {
       // fmt.Println("bad: %s", string(tokenDecoded))
//    }
//    tokenDecoded  := base64.RawStdEncoding.DecodeString(tokenEncoded)
//    fmt.Println("token: ", string(tokenEncoded))
	                  
}

